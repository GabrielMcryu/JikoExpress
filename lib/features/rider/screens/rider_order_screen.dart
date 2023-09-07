import 'package:jiko_express/common/widgets/loader.dart';
import 'package:jiko_express/features/restaurant/widgets/single_meal.dart';
import 'package:jiko_express/features/rider/screens/rider_order_details_screen.dart';
import 'package:jiko_express/features/rider/services/rider_service.dart';
import 'package:jiko_express/models/order.dart';
import 'package:flutter/material.dart';

class RiderOrderScreen extends StatefulWidget {
  const RiderOrderScreen({super.key});

  @override
  State<RiderOrderScreen> createState() => _RiderOrderScreenState();
}

class _RiderOrderScreenState extends State<RiderOrderScreen> {
  List<Order>? orders;
  final RiderServices riderServices = RiderServices();

  @override
  void initState() {
    super.initState();
    fetchAssignedOrders();
  }

  void fetchAssignedOrders() async {
    orders = await riderServices.fetchAssignedOrders(context);
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
                  RiderOrderDetailsScreen.routeName,
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
