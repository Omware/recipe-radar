import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/providers/recipe_provider.dart';
import 'package:recipes/screens/recipe_detail.dart';
import 'package:recipes/widgets/recipe_card.dart';

class RecipesList extends ConsumerStatefulWidget {
  const RecipesList({super.key});

  @override
  ConsumerState<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends ConsumerState<RecipesList> {
  late Future<List<Result>?> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture =
        ref.read(recipeProvider.notifier).fetchRecipes('main course');
  }

  @override
  Widget build(BuildContext context) {
    
    final recipes = ref.watch(recipeProvider);

    return FutureBuilder(
        future: _recipesFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xfffe8d15),
              ),
            );
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Text('${snapshot.error}');
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.0),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (ctx, index) {
                return RecipeCard(
                  recipeName: recipes![index].title,
                  imageUrl: recipes[index].image,
                  onSelectRecipe: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => RecipeDetail(
                                recipeId: recipes[index].id,
                              ))),
                );
              });
        }));
  }
}
