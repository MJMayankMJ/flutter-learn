import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavoriteMealStatus(Meal meal) {
    //note that we cant use .add and .remove cz statenotifier doesnt allow that
    //so here we first find out that if the meal is part of the list or not
    //and than we create a new list on that new information
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      //we have to remove it from the list without using .remove
      state = state.where((m) => m.id != meal.id).toList();
      //.where filters and create new list so it doesnt change
      //so if id doesnt match we keep it otherwise we remove it thereby removing without .remove
      return false;
    }
    //now to add
    else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
