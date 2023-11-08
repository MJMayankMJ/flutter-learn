import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });
  //for the favorites the initial list was empty but for the filter the initial state should be map of filters and bool value

  void setAllFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[Filter] = isActive // its not allowed cz it is mutating and u cant do that here
    state = {
      ...state,
      filter: isActive, // this overides the respective new key value pair
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  //thats just for better typing support
  (ref) => FiltersNotifier(),
);
