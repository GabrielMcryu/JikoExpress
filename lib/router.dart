
import 'package:flutter/material.dart';
import 'features/auth/screens/customer_auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case CustomerAuthScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CustomerAuthScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Screen does not exist!'),
            ),
          ),
        );
    }
}