import 'package:jiko_express/common/widgets/loader.dart';
import 'package:jiko_express/features/restaurant/widgets/single_meal.dart';
import 'package:jiko_express/features/restaurant/screens/restaurant_order_detail_screen.dart';
import 'package:jiko_express/features/restaurant/services/restaurant_services.dart';
import 'package:jiko_express/models/order.dart';
import 'package:flutter/material.dart';

class RestaurantOrderScreen extends StatefulWidget {
  const RestaurantOrderScreen({super.key});

  @override
  State<RestaurantOrderScreen> createState() => _RestaurantOrderScreenState();
}

class _RestaurantOrderScreenState extends State<RestaurantOrderScreen> {
  List<Order>? orders;
  final RestaurantServices restaurantServices = RestaurantServices();

  @override
  void initState() {
    super.initState();
    fetchRestaurantOrders();
  }

  void fetchRestaurantOrders() async {
    orders = await restaurantServices.fetchRestaurantOrders(context);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
          itemCount: orders!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            final orderData = orders![index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RestaurantOrderDetailsScreen.routeName,
                  arguments: orderData,
                );
              },
              child: SizedBox(
                height: 140,
                child: SingleMeal(
                  image: orderData.meals[0].images[0],
                ),
              ),
            );
          },
        );
  }
}
