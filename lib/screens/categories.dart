import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availabelMeals});
  final List<Meal> availabelMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _animationController; //osed to indicate that a non-nullable variable will be initialized later in the code. tanna ota animationcontroller vhayesi use TickleProviderStateMixin

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 1,
      lowerBound: 0, //default
    );
    _animationController.forward(); //animation started
  }

  @override
  void dispose() {
    _animationController.dispose(); //screen hatepaxi memory ,a rahi narahos
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    void _selectCategory(BuildContext context, Category category) {
      // final filteredMeals = dummyMeals
      //     .where((meal) => meal.categories.contains(category.id))
      //     .toList();
      final filteredMeals = widget.availabelMeals
          .where((meal) => meal.categories.contains(category.id))
          .toList();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) {
          return MealScreen(
            meals: filteredMeals,
            title: category.title,
          );
        }),
      );

      // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealScreen(meals: dummyMeals, title: 'hi'))) mathi ko jastai second approacg
    }

    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.5,
          ),
          padding: EdgeInsets.all(24),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              ),
          ]

          /*  availableCategories
                  .map((category) => CategoryGridItem(
                      category: category,
                      onSelectCategory: () {
                        _selectCategory(context);
                      }))
                  .toList(), */

          ),
      // builder: (context, child) => Padding(
      //   padding: EdgeInsets.only(top:100- _animationController.value * 100),
      //   child: child,
      // ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, 0.3),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      ),
    );
  }
}
