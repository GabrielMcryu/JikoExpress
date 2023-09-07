
import 'package:flutter/material.dart';
import 'models/restaurant.dart';
import 'models/meal.dart';
import 'models/order.dart';
import 'features/auth/screens/customer_auth_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/auth/screens/restaurant_auth_screen.dart';
import 'features/auth/screens/rider_auth_screen.dart';
import 'features/customer/screens/customer_home_screen.dart';
import 'features/restaurant/screens/restaurant_home_screen.dart';
import 'features/rider/screens/rider_home_screen.dart';
import 'features/restaurant/screens/restaurant_add_meal_screen.dart';
import 'features/restaurant/screens/restaurant_hire_rider_screen.dart';
import 'features/restaurant/screens/restaurant_order_detail_screen.dart';
import 'features/restaurant/screens/restaurant_assign_rider_screen.dart';
import 'features/customer/screens/customer_restaurant_meal_screen.dart';
import 'features/customer/screens/customer_meal_detail_screen.dart';
import 'features/customer/screens/customer_address_screen.dart';
import 'features/customer/screens/customer_order_detail_screen.dart';

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
      case CustomerAddressScreen.routeName:
        var totalAmount = routeSettings.arguments as String;
        return MaterialPageRoute(
          settings: routeSettings,
            builder: (_) => CustomerAddressScreen(
                totalAmount: totalAmount,
            ),
        );
      case CustomerOrderDetailsScreen.routeName:
        var order = routeSettings.arguments as Order;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CustomerOrderDetailsScreen(
            order: order,
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
      case RestaurantHireRiderScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RestaurantHireRiderScreen(),
        );
      case RestaurantAssignRiderScreen.routeName:
        var orderId = routeSettings.arguments as String;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => RestaurantAssignRiderScreen(
            orderId: orderId,
          ),
        );
      case RiderHomeScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RiderHomeScreen(),
        );
      case RestaurantOrderDetailsScreen.routeName:
        var order = routeSettings.arguments as Order;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => RestaurantOrderDetailsScreen(
            order: order,
          ),
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