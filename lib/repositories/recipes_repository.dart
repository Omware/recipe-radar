import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/exceptions/exceptions.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/models/recipe_ingredients.dart';
import 'package:recipes/utils/config.dart';

class RecipeRepository {
  final http.Client client;
  final Connectivity connectivity;

  RecipeRepository({required this.client, required this.connectivity});

  Future<List<Result>?> fetchRecipes(String type) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw NoInternetException();
      }

      var url = Uri.https('api.spoonacular.com', 'recipes/complexSearch',
          {'apiKey': Config.apikey, 'type': type});
      var response = await client.get(url);
      // print(response.request);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> recipes = data['results'];
        print('------ $recipes');

        List<Result> results =
            recipes.map((recipe) => Result.fromJson(recipe)).toList();

        return results;
      } else {
        throw ApiException('Failed to fetch recipes');
      }
    } catch (e) {
      throw ApiException("Error Fetching Recipes: $e");
    }
  }

  Future<Map<String, dynamic>> fetchRecipeInfo(int id) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw NoInternetException();
      }

      var url = Uri.https('api.spoonacular.com', 'recipes/$id/information',
          {'apiKey': Config.apikey, 'cuisine': 'british'});
      var response = await client.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        List<dynamic> extendedIngredientsdata = data['extendedIngredients'];

        List<ExtendedIngredient> extendedIngredients = extendedIngredientsdata
            .map((recipe) => ExtendedIngredient.fromJson(recipe))
            .toList();

        return {
          'readyInMinutes': data['readyInMinutes'],
          'extendedIngredients': extendedIngredients,
          'image': data['image'],
          'title': data['title'],
          'summary': data['summary'],
          'aggregateLikes': data['aggregateLikes']
        };
      } else {
        throw ApiException('Failed to fetch recipe information');
      }
    } catch (e) {
      throw ApiException('Error fetching recipe information: $e');
    }
  }

  Future<void> toggleFavorite(int id, String title, String recipeImage) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw NoInternetException();
      }

      final recipe = await FirebaseFirestore.instance
          .collection('savedRecipes')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userRecipes')
          .doc(id.toString());

      final snapshot = await recipe.get();

      if (snapshot.exists) {
        await recipe.delete();
      } else {
        recipe.set({'id': id, 'title': title, 'recipeImage': recipeImage});
      }
    } catch (e) {
      throw ApiException('Error deleting recipe: $e');
    }
  }

  Future<bool> isRecipeFavorite(int recipeId) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw NoInternetException();
      }

      final docRef = FirebaseFirestore.instance
          .collection('savedRecipes')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userRecipes')
          .doc(recipeId.toString());
      return docRef.get().then((docSnapshot) => docSnapshot.exists);
    } catch (e) {
      throw ApiException('Error deleting recipe: $e');
    }
  }
}
