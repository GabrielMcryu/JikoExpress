import 'package:flutter/material.dart';

class RestaurantMealScreen extends StatefulWidget {
  const RestaurantMealScreen({super.key});

  @override
  State<RestaurantMealScreen> createState() => _RestaurantMealScreenState();
}

class _RestaurantMealScreenState extends State<RestaurantMealScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text(
            "Restaurant Meal Screen",
            style: TextStyle(
              fontSize: 24, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
          ),
        )
    );
  }
}
