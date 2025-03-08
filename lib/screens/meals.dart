import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_details.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    super.key,
    required this.meals,
    this.title,
  });
  final String? title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    void selectmeal(BuildContext context, Meal meal) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return MealDetailsScreen(meal: meal ,);
      }));
    }

    Widget content = ListView.builder(itemBuilder: (ctx, index) {
      return Text(meals[index].title);
    });
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Opps nothing here ',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'try selecting a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }
    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
                meal: meals[index],
                onSelectMeal: (meal) {
                  selectmeal(context, meal);
                });
          });
    }
    if (title == null) {
      return content;
    } else
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content,
      );
  }
}
