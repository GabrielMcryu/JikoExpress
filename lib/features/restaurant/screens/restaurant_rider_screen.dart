import 'package:jiko_express/common/widgets/loader.dart';
import 'package:jiko_express/constants/global_variables.dart';
import './restaurant_hire_rider_screen.dart';
import 'package:jiko_express/features/restaurant/services/restaurant_services.dart';
import 'package:jiko_express/models/rider.dart';
import 'package:flutter/material.dart';

class RestaurantRiderScreen extends StatefulWidget {
  const RestaurantRiderScreen({super.key});

  @override
  State<RestaurantRiderScreen> createState() => _RestaurantRiderScreenState();
}

class _RestaurantRiderScreenState extends State<RestaurantRiderScreen> {
  List<Rider>? riders;
  final RestaurantServices restaurantServices = RestaurantServices();

  @override
  void initState() {
    super.initState();
    fetchRestaurantRiders();
  }

  fetchRestaurantRiders() async {
    riders = await restaurantServices.fetchRestaurantRiders(context);
    setState(() {

    });
  }

  void navigateToHireRider() {
    Navigator.pushNamed(context, RestaurantHireRiderScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return riders == null
      ? const Loader()
      : Scaffold(
        body: ListView.builder(
          itemCount: riders!.length,
            itemBuilder: (context, index) {
              final riderData = riders![index];
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
                    riderData.drivingLicenseNumber,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.motorcycle_outlined,
                      color: GlobalVariables.secondaryColor,
                    ),
                  ),
                ),
              );
            }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToHireRider,
          tooltip: 'Hire Rider',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
