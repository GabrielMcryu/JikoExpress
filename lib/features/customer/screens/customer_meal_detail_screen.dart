import 'package:jiko_express/common/widgets/custom_button.dart';
import 'package:jiko_express/features/restaurant/widgets/single_meal.dart';
import 'package:jiko_express/features/customer/services/customer_services_screen.dart';
import 'package:jiko_express/providers/user_provider.dart';
import 'package:carousel_slider/carousel_controller.dart';

import 'package:jiko_express/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:provider/provider.dart';

class CustomerMealDetailScreen extends StatefulWidget {
  static const String routeName = '/customer-meal-details';
  final Meal meal;

  const CustomerMealDetailScreen({super.key, required this.meal});

  @override
  State<CustomerMealDetailScreen> createState() => _CustomerMealDetailScreenState();
}

class _CustomerMealDetailScreenState extends State<CustomerMealDetailScreen> {
  final CustomerServices customerServices = CustomerServices();

  void addToCart() {
    customerServices.addToCart(
        context: context,
        meal: widget.meal
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         widget.meal.id!,
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Text(
                  widget.meal.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: SingleMeal(
                  image: widget.meal.images[0],
                ),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: RichText(
                  text: TextSpan(
                    text: 'Deal Price: ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Kshs: ${widget.meal.price}',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.meal.description),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  text: 'Add to Cart',
                  onTap: addToCart,
                  color: const Color.fromRGBO(254, 216, 19, 1),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.black12,
                height: 5,
              ),
            ],
          ),
        ),
    );
  }
}
