import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard(
      {super.key,
      required this.name,
      required this.ingredientImage,
      required this.amount});
  final String name;
  final String ingredientImage;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: ingredientImage == 'no.jpg'
            ? const NetworkImage(
                'https://res.cloudinary.com/dycuxocgb/image/upload/v1713258455/no_qjinul.jpg')
            : NetworkImage(
                'https://img.spoonacular.com/ingredients_100x100/$ingredientImage'),
      ),
      title: Text(name),
      trailing: Text(amount.toInt().toString()),
    );
  }
}
