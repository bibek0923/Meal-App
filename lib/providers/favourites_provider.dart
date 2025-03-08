import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier()
      : super(
            []); //this constructor doesnt take or pass arguments , it is initialized by super i.e initial data
  //initial value edit garna mildaina change nai garnu parchha ...//super vitra ko  value edit garna mildaina ,change nai garna parchha..tei vayera .add haru garna mildaina tyo list ma
  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList(); //confusing
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
        (ref) => FavouriteMealsNotifier());
