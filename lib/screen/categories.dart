import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //if u have more than one animation controller use TickerProviderStateMixin
  late AnimationController
      _animationController; //this animation controller must be set before the build method is executed
  // late : tell that the following word is a variable and will have a value as soon as its being used the first time but not yet when the class is created
  // ie there is a timing diff. when this property is technically created, when it will have an initail value and when it will be needed for 1st time

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1, //this is default anyways
    );

    _animationController.forward(); // to start the animation
    // note : when we move to filters an move back the animation is not done cz the state is not recreated because categories screen was already on stack and is not recreated thus no animation
  }

  @override
  void dispose() {
    _animationController.dispose(); // to prevent memory leaks
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    //Navigator.push(context, route)
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        // the child below is for the widget whom u dont want to rebuild
        child: GridView(
          //we dont use .builder cz there wont be too many cateories for performance optimisation
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            //availableCategories.map((category) => CategoryGridItem(category : category)).toList()
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              )
          ],
        ),
        // builder: (context, child) => Padding(
        //       padding: EdgeInsets.only(
        //           top: 100 -
        //               _animationController.value *
        //                   100), // .value give access to current value, ie. btw 0 and 1 and when we multiply it by 100 it is btw 0 and 100
        //       child: child,
        //     ));
        // the below method just give us more controll over the animation and is more optimised
        builder: (context, child) => SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut)),

            // drive simply allows us to traslate our animation btw 0 and 1 to a animation btw 2 other values (offset)
            child: child));
  }
}
