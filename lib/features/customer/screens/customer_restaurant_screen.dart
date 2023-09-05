import 'package:jiko_express/common/widgets/loader.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/features/customer/services/customer_services_screen.dart';
import 'package:jiko_express/models/restaurant.dart';
import 'package:jiko_express/features/customer/screens/customer_restaurant_meal_screen.dart';
import 'package:flutter/material.dart';

class CustomerRestaurantScreen extends StatefulWidget {
  const CustomerRestaurantScreen({super.key});

  @override
  State<CustomerRestaurantScreen> createState() => _CustomerRestaurantScreenState();
}

class _CustomerRestaurantScreenState extends State<CustomerRestaurantScreen> {
  List<Restaurant>? restaurants;
  final CustomerServices customerServices = CustomerServices();

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  fetchRestaurants() async {
    restaurants = await customerServices.fetchRestaurants(context: context);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return restaurants == null
    ? const Loader()
    : Scaffold(
        body: ListView.builder(
          itemCount: restaurants!.length,
          itemBuilder: (context, index) {
            final restaurantData = restaurants![index];
            return Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: GlobalVariables.secondaryColor, // You can specify the color of the border
                  width: 1.0, // You can specify the width of the border
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0), // Add padding to ListTile
                title: Text(
                  restaurantData.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      CustomerRestaurantMealScreen.routeName,
                      arguments: restaurantData,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward_outlined,
                    color: GlobalVariables.secondaryColor,
                  ),
                ),
              ),
            );
          }
        )
    );
  }
}
