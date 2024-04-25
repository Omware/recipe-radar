import 'package:flutter/material.dart';

class FavoritesCard extends StatelessWidget {
  const FavoritesCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.recipeId, required this.onSelectRecipe});
  final String recipeId;
  final String title;
  final String imageUrl;
  final void Function() onSelectRecipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelectRecipe,
      child: Card(
        elevation: 0,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        margin: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: imageUrl == null
                      ? Image.asset('assets/image-load-failed.png')
                      : Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          height: 100.0,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/image-load-failed.png');
                          },
                        ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      softWrap: true,
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
