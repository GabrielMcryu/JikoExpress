import 'package:flutter/material.dart';
import 'package:jiko_express/common/widgets/custom_button.dart';
import 'package:jiko_express/features/auth/services/auth_service.dart';

class CustomerAccountScreen extends StatefulWidget {
  const CustomerAccountScreen({super.key});

  @override
  State<CustomerAccountScreen> createState() => _CustomerAccountScreenState();
}

class _CustomerAccountScreenState extends State<CustomerAccountScreen> {
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
