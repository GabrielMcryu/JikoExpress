import 'package:jiko_express/common/widgets/loader.dart';
import 'package:jiko_express/features/restaurant/widgets/single_meal.dart';
import 'package:jiko_express/features/customer/services/customer_services_screen.dart';
import 'package:jiko_express/features/customer/screens/customer_order_detail_screen.dart';
import 'package:jiko_express/models/order.dart';
import 'package:flutter/material.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({super.key});

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  List<Order>? orders;
  final CustomerServices customerServices = CustomerServices();

  @override
  void initState() {
    super.initState();
    fetchOrdersByCustomer();
  }

  void fetchOrdersByCustomer() async {
    orders = await customerServices.fetchCustomerOrders(context: context);
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
              CustomerOrderDetailsScreen.routeName,
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
