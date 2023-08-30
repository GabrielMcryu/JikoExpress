import 'package:flutter/material.dart';

class RestaurantRiderScreen extends StatefulWidget {
  const RestaurantRiderScreen({super.key});

  @override
  State<RestaurantRiderScreen> createState() => _RestaurantRiderScreenState();
}

class _RestaurantRiderScreenState extends State<RestaurantRiderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text(
            "Restaurant Rider Screen",
            style: TextStyle(
              fontSize: 24, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
          ),
        )
    );
  }
}
