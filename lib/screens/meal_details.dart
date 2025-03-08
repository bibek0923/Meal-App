import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    final isFavourite = favouriteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favouriteMealsProvider.notifier)
                    .toggleMealFavouriteStatus(
                        meal); //gives access to notifier class ..fn vitra watch use nagarne
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded
                        ? "Meal Added as a favourite"
                        : "Meal removed"),
                  ),
                );
              },
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => RotationTransition(
               //   turns: animation,
               turns:  Tween<double>(
                begin: 0.5,
                end: 0.6,
               ).animate(animation),
                  child: child,
                ),
                child: Icon(
                  isFavourite ? Icons.star : Icons.star_border,
                  key: ValueKey(isFavourite),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag : meal.id,
                child: Image.network(
                  
                  meal.imageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: TextStyle(color: Colors.blueGrey),
                ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    step,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}
