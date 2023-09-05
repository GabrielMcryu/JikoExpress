import 'package:jiko_express/common/widgets/loader.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/features/customer/services/customer_services_screen.dart';
import 'package:jiko_express/features/customer/screens/customer_meal_detail_screen.dart';
import 'package:jiko_express/features/restaurant/widgets/single_meal.dart';
import 'package:jiko_express/models/restaurant.dart';
import 'package:jiko_express/models/meal.dart';
import 'package:flutter/material.dart';

class CustomerRestaurantMealScreen extends StatefulWidget {
  static const String routeName = '/customer-restaurant-meals';
  final Restaurant restaurant;

  const CustomerRestaurantMealScreen({super.key, required this.restaurant});

  @override
  State<CustomerRestaurantMealScreen> createState() => _CustomerRestaurantMealScreenState();
}

class _CustomerRestaurantMealScreenState extends State<CustomerRestaurantMealScreen> {
  List<Meal>? mealList;
  final CustomerServices customerServices = CustomerServices();

  @override
  void initState() {
    super.initState();
    fetchRestaurantMeals();
  }

  fetchRestaurantMeals() async {
    mealList = await customerServices.fetchRestaurantMeals(
        context: context,
        restaurantId: widget.restaurant.id,
    );
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jiko Express',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Customer',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: mealList == null
          ? const Loader()
          : GridView.builder(
            itemCount: mealList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final meal = mealList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CustomerMealDetailScreen.routeName,
                    arguments: meal,
                  );
                },
                child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleMeal(
                          image: meal.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              meal.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                ),
              );
            },
          ),
    );
  }
}
