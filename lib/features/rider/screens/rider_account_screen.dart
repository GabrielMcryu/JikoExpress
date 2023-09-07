import 'package:jiko_express/constants/global_variables.dart';
import './rider_order_screen.dart';
import './rider_account_screen.dart';
import 'package:flutter/material.dart';

class RiderAccountScreen extends StatefulWidget {
  const RiderAccountScreen({super.key});

  @override
  State<RiderAccountScreen> createState() => _RiderAccountScreenState();
}

class _RiderAccountScreenState extends State<RiderAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Rider Account Screen",
          style: TextStyle(
            fontSize: 24, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Adjust the font weight as needed
          ),
        ),
      ),
    );
  }
}
