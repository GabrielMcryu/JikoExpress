
import 'package:flutter/material.dart';
import 'models/restaurant.dart';
import 'models/meal.dart';
import 'features/auth/screens/customer_auth_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/auth/screens/restaurant_auth_screen.dart';
import 'features/auth/screens/rider_auth_screen.dart';
import 'features/customer/screens/customer_home_screen.dart';
import 'features/restaurant/screens/restaurant_home_screen.dart';
import 'features/rider/screens/rider_home_screen.dart';
import 'features/restaurant/screens/restaurant_add_meal_screen.dart';
import 'features/customer/screens/customer_restaurant_meal_screen.dart';
import 'features/customer/screens/customer_meal_detail_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case AuthScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AuthScreen(),
        );
      case CustomerAuthScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CustomerAuthScreen(),
        );
      case RestaurantAuthScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RestaurantAuthScreen(),
        );
      case RiderAuthScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RiderAuthScreen(),
        );
      case CustomerHomeScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CustomerHomeScreen(),
        );
      case CustomerRestaurantMealScreen.routeName:
        var restaurant = routeSettings.arguments as Restaurant;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CustomerRestaurantMealScreen(
              restaurant: restaurant
          ),
        );
      case CustomerMealDetailScreen.routeName:
        var meal = routeSettings.arguments as Meal;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CustomerMealDetailScreen(
              meal: meal
          ),
        );
      case RestaurantHomeScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RestaurantHomeScreen(),
        );
      case RestaurantAddMealScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RestaurantAddMealScreen(),
        );
      case RiderHomeScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RiderHomeScreen(),
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