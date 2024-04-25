import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes/models/recipe_ingredients.dart';
import 'package:recipes/providers/recipe_info_provider.dart';
import 'package:recipes/widgets/ingredients_card.dart';

class RecipeDetail extends ConsumerWidget {
  const RecipeDetail({
    super.key,
    required this.recipeId,
  });

  final int recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String getTitle(String title) {
      return title[0].toUpperCase() + title.substring(1);
    }

    var recipeDetailsFuture =
        ref.read(recipeInformationProvider.notifier).fetchRecipeInfo(recipeId);

    var imageHeight = MediaQuery.of(context).size.height * 0.30;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Recipe Detail'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark_border,
                color: Color(0xfffe8d15),
              ))
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: FutureBuilder(
                future: recipeDetailsFuture,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Text('${snapshot.error}');
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  List<ExtendedIngredient> ingredients =
                      snapshot.data!['extendedIngredients'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: snapshot.data!['image'] == null
                            ? Image.asset(
                                'assets/image-load-failed.png',
                                height: imageHeight,
                              )
                            : Image.network(
                                snapshot.data!['image'],
                                fit: BoxFit.cover,
                                height: imageHeight,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/image-load-failed.png',
                                    height: imageHeight,
                                  );
                                },
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              snapshot.data!['title'],
                              softWrap: true,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 254, 21, 21),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('${snapshot.data!['aggregateLikes']}'),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.alarm,
                            color: Color(0xfffe8d15),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('${snapshot.data!['readyInMinutes']} min'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // ingredients list
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: ingredients
                            .map((ingredient) => IngredientCard(
                                name: getTitle(ingredient.name),
                                ingredientImage: ingredient.image,
                                amount: ingredient.amount))
                            .toList(),
                      )
                    ],
                  );
                }))),
      ),
    );
  }
}
