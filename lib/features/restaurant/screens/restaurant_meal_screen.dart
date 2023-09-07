import 'package:jiko_express/common/widgets/loader.dart';
import 'package:jiko_express/features/restaurant/widgets/single_meal.dart';
import './restaurant_add_meal_screen.dart';
import 'package:jiko_express/features/restaurant/services/restaurant_services.dart';
import 'package:jiko_express/models/meal.dart';
import 'package:flutter/material.dart';

class RestaurantMealScreen extends StatefulWidget {
  const RestaurantMealScreen({super.key});

  @override
  State<RestaurantMealScreen> createState() => _RestaurantMealScreenState();
}

class _RestaurantMealScreenState extends State<RestaurantMealScreen> {
  List<Meal>? meals;
  final RestaurantServices restaurantServices = RestaurantServices();

  @override
  void initState() {
    super.initState();
    fetchRestaurantMeals();
  }

  fetchRestaurantMeals() async {
    meals = await restaurantServices.fetchRestaurantMeals(context);
    setState(() {

    });
  }

  void deleteMeal(Meal meal, int index) {
    restaurantServices.deleteMeal(
        context: context,
        meal: meal,
        onSuccess: () {
          meals!.removeAt(index);
          setState(() {

          });
        }
    );
  }

  void navigateToAddMeal() {
    Navigator.pushNamed(context, RestaurantAddMealScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return meals == null
      ? const Loader()
      : Scaffold(
        body: GridView.builder(
          itemCount: meals!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            final mealData = meals![index];
            return Column(
              children: [
                SizedBox(
                  height: 140,
                  child: SingleMeal(
                    image: mealData.images[0],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Text(
                          mealData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                    ),
                    IconButton(
                        onPressed: () => deleteMeal(mealData, index),
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                    ),
                  ],
                )
              ]
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToAddMeal,
          tooltip: 'Add a Meal',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
