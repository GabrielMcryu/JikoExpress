import 'package:jiko_express/common/widgets/loader.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/features/restaurant/services/restaurant_services.dart';
import 'package:jiko_express/models/rider.dart';
import 'package:flutter/material.dart';
import 'package:jiko_express/features/restaurant/screens/restaurant_home_screen.dart';

class RestaurantAssignRiderScreen extends StatefulWidget {
  static const String routeName = '/assign-rider';
  final String orderId;
  const RestaurantAssignRiderScreen({super.key, required this.orderId});

  @override
  State<RestaurantAssignRiderScreen> createState() => _RestaurantAssignRiderScreenState();
}

class _RestaurantAssignRiderScreenState extends State<RestaurantAssignRiderScreen> {
  List<Rider>? riders;
  final RestaurantServices restaurantServices = RestaurantServices();

  @override
  void initState() {
    super.initState();
    fetchAvailableRiders();
  }

  fetchAvailableRiders() async {
    riders = await restaurantServices.fetchAvailableRestaurantRiders(context);
    setState(() {

    });
  }

  void assignOrderToRider(Rider rider, int index) {
    restaurantServices.assignOrderToRider(
        context: context,
        rider: rider,
        orderId: widget.orderId,
        onSuccess: () {
          Navigator.pushNamedAndRemoveUntil(
              context,
              RestaurantHomeScreen.routeName,
              (route) => false,
          );
        }
    );
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
          title: const Text(
            'Hire Rider',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: riders == null
          ? const Loader()
          : ListView.builder(
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
                  onPressed: () => assignOrderToRider(riderData, index),
                  icon: const Icon(
                    Icons.add_circle_outline_outlined,
                    color: GlobalVariables.secondaryColor,
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
