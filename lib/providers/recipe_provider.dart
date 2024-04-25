import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/repositories/recipes_repository.dart';

class RecipePlacesNotifier extends StateNotifier<List<Result>> {
  final RecipeRepository repository;

  @override
  void dispose() {
    super.dispose();
    repository.client.close();
  }

  RecipePlacesNotifier(this.repository) : super([]);

  Future<List<Result>?> fetchRecipes(String type) async {
    try {
      final recipes = await repository.fetchRecipes(type);
      state = recipes!;
      return recipes;
    } catch (e) {
      state = [];
      rethrow;
    }
  }
}

final recipeProvider = StateNotifierProvider<RecipePlacesNotifier,
        List<Result>?>(
    (ref) => RecipePlacesNotifier(
        RecipeRepository(client: http.Client(), connectivity: Connectivity())));
