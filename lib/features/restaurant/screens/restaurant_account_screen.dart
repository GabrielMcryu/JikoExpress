import 'package:flutter/material.dart';

class RestaurantAccountScreen extends StatefulWidget {
  const RestaurantAccountScreen({super.key});

  @override
  State<RestaurantAccountScreen> createState() => _RestaurantAccountScreenState();
}

class _RestaurantAccountScreenState extends State<RestaurantAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text(
            "Restaurant Account Screen",
            style: TextStyle(
              fontSize: 24, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
          ),
        ),
    );
  }
}
