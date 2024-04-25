import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/screens/recipe_detail.dart';
import 'package:recipes/widgets/favorites_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('savedRecipes')
              .doc(authenticatedUser!.uid)
              .collection('userRecipes')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No recipes'),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error.toString()}'),
              );
            }
            final loadedItems = snapshot.data!.docs;

            return ListView.builder(
                itemCount: loadedItems.length,
                itemBuilder: (ctx, index) {
                  return Dismissible(
                    background: Container(
                      margin: const EdgeInsets.all(5.0),
                      color: const Color.fromARGB(209, 248, 26, 26),
                    ),
                    key: ValueKey(loadedItems[index].data()),
                    onDismissed: (direction) async {
                      await FirebaseFirestore.instance
                          .collection('savedRecipes')
                          .doc(authenticatedUser.uid)
                          .collection('userRecipes')
                          .doc(loadedItems[index].data()['id'])
                          .delete();
                    },
                    child: FavoritesCard(
                      recipeId: loadedItems[index].data()['id'],
                      title: loadedItems[index].data()['title'],
                      imageUrl: loadedItems[index].data()['recipeImage'],
                      onSelectRecipe: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => RecipeDetail(
                                    recipeId: int.parse(
                                        loadedItems[index].data()['id']),
                                  ))),
                    ),
                  );
                });
          }),
    );
  }
}
