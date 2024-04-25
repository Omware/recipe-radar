import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String recipeName;
  final String imageUrl;
  final void Function() onSelectRecipe;

  const RecipeCard(
      {super.key,
      required this.recipeName,
      required this.imageUrl,
      required this.onSelectRecipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelectRecipe,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                recipeName,
                softWrap: true,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
