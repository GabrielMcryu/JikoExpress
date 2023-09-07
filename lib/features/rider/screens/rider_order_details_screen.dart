import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:jiko_express/models/order.dart';
import 'package:provider/provider.dart';
import 'package:jiko_express/features/rider/services/rider_service.dart';
import 'package:jiko_express/features/rider/screens/rider_home_screen.dart';
import 'package:flutter/material.dart';

class RiderOrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/rider-order-details';
  final Order order;
  const RiderOrderDetailsScreen({super.key, required this.order});

  @override
  State<RiderOrderDetailsScreen> createState() => _RiderOrderDetailsScreenState();
}

class _RiderOrderDetailsScreenState extends State<RiderOrderDetailsScreen> {
  final RiderServices riderServices = RiderServices();

  String getOrderStatusString(int orderStatus) {
    switch (orderStatus) {
      case 0:
        return 'Preparing';
      case 1:
        return 'Delivering';
      case 2:
        return 'Complete';
      default:
        return 'Unknown'; // You can provide a default value for unexpected statuses
    }
  }

  void completeOrder(BuildContext context, Order order) {
    riderServices.completeOrder(
        context: context,
        order: order,
        onSuccess: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RiderHomeScreen.routeName,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date:      ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.order.orderedAt),
                    )}'),
                    Text('Order ID:          ${widget.order.id}'),
                    Text('Order Total:     Kshs: ${widget.order.totalPrice}'),
                    Text('Order Status:   ${getOrderStatusString(widget.order.status)}')
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.meals.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.meals[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.meals[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Qty: ${widget.order.quantity[i]}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          completeOrder(context, widget.order);
        },
        tooltip: 'Complete Order',
        child: const Icon(Icons.done),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
