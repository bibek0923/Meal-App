import 'package:flutter/material.dart';

import 'package:meal_app/models/category.dart';
//import 'package:meal_app/screens/categories.dart';

class CategoryGridItem extends StatelessWidget {
 /* void go(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealScreen(meals: dummyMeals, title: 'hello'),
        ));
  } */ //esari hudaina , widget ma define garera ..screen ma define garne and navigate

  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});
  final Category category;
  final void Function() onSelectCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
     /* onTap: () {
        go;
      },*/
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(colors: [
              category.color.withOpacity(0.4),
              category.color.withOpacity(0.9),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
