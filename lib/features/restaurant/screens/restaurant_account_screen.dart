import 'package:flutter/material.dart';
import 'package:jiko_express/common/widgets/custom_button.dart';
import 'package:jiko_express/features/auth/services/auth_service.dart';

class RestaurantAccountScreen extends StatefulWidget {
  const RestaurantAccountScreen({super.key});

  @override
  State<RestaurantAccountScreen> createState() => _RestaurantAccountScreenState();
}

class _RestaurantAccountScreenState extends State<RestaurantAccountScreen> {
  AuthService authService = AuthService();
  void logout() {
    authService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: 'Logout',
            onTap: logout,
          ),
        ],
      ),
    );
  }
}
