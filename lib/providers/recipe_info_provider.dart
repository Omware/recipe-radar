import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:recipes/repositories/recipes_repository.dart';

class RecipeInfoNotifier extends StateNotifier<Map<String, dynamic>> {
  final RecipeRepository repository;

  RecipeInfoNotifier(this.repository) : super({});

  Future<Map<String, dynamic>> fetchRecipeInfo(int id) async {
    try {
      final data = await repository.fetchRecipeInfo(id);
      state = data;
      return state;
    } catch (e) {
      state = {};
      rethrow; // Rethrow the error to maintain the original stack trace
    }
  }

  @override
  void dispose() {
    super.dispose();
    repository.client.close();
  }
}

final recipeInformationProvider =
    StateNotifierProvider<RecipeInfoNotifier, Map<String, dynamic>>((ref) =>
        RecipeInfoNotifier(RecipeRepository(
            client: http.Client(), connectivity: Connectivity())));
