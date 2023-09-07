import 'package:jiko_express/common/widgets/custom_button.dart';
import 'package:jiko_express/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class RiderAccountScreen extends StatefulWidget {
  const RiderAccountScreen({super.key});

  @override
  State<RiderAccountScreen> createState() => _RiderAccountScreenState();
}

class _RiderAccountScreenState extends State<RiderAccountScreen> {
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
