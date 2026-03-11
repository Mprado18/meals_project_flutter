import 'package:flutter/material.dart';
import 'package:meals_project/components/meal_item.dart';
import 'package:meals_project/model/meal.dart';

class FavoritesFoodScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoritesFoodScreen(this.favoriteMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(child: Text('Nenhuma refeição foi marcada como favorita!'));
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(favoriteMeals[index]);
        },
      );
    }
  }
}
