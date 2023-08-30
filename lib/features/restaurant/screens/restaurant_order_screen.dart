import 'package:flutter/material.dart';

class RestaurantOrderScreen extends StatefulWidget {
  const RestaurantOrderScreen({super.key});

  @override
  State<RestaurantOrderScreen> createState() => _RestaurantOrderScreenState();
}

class _RestaurantOrderScreenState extends State<RestaurantOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text(
            "Restaurant Order Screen",
            style: TextStyle(
              fontSize: 24, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
          ),
        )
    );
  }
}
