import 'package:flutter/material.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/common/widgets/custom_button.dart';
import 'customer_auth_screen.dart';
import 'restaurant_auth_screen.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  void navigateToCustomerAuthScreen(BuildContext context) {
    Navigator.pushNamed(context, CustomerAuthScreen.routeName);
  }

  void navigateToRestaurantAuthScreen(BuildContext context) {
    Navigator.pushNamed(context, RestaurantAuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/jiko-express-logo-white.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            CustomButton(
                text: 'Log in as a Customer',
                onTap: () {
                  navigateToCustomerAuthScreen(context);
                }
            ),
            const SizedBox(height: 20),
            CustomButton(
                text: 'Log in as a Restaurant',
                onTap: () {
                  navigateToRestaurantAuthScreen(context);
                }
            ),
            const SizedBox(height: 20),
            CustomButton(
                text: 'Log in as a Rider',
                onTap: () {

                }
            ),
          ],
        ),
      ),
    );
  }
}
