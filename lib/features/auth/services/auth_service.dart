import 'dart:convert';

import 'package:jiko_express/constants/error_handling.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/constants/utils.dart';
import 'package:jiko_express/features/auth/screens/auth_screen.dart';
import 'package:jiko_express/providers/user_provider.dart';
import 'package:jiko_express/features/customer/screens/customer_home_screen.dart';
import 'package:jiko_express/features/restaurant/screens/restaurant_home_screen.dart';
import 'package:jiko_express/features/rider/screens/rider_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jiko_express/models/user.dart';
import '../models/payload.dart';

class AuthService {

  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        address: '',
        role: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created! Login with the same credentials');
        },
      );
    } catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  void signUpRestaurant({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String restaurantName,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/api/restaurant-signup'),
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
            'phoneNumber': phoneNumber,
            'restaurantName': restaurantName,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created! Login with the same credentials');
        },
      );
    } catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  void signUpRider({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String drivingLicenseNumber,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/api/rider-signup'),
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
            'phoneNumber': phoneNumber,
            'drivingLicenseNumber': drivingLicenseNumber,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created! Login with the same credentials');
        },
      );
    } catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          String? toks  = prefs.getString('x-auth-token');
          if (toks != null) {
            final encodedPayload = toks.split('.')[1];
            final payloadData =
                utf8.fuse(base64).decode(base64.normalize(encodedPayload));
            print('payload: $payloadData');
            Payload decodedPayload = Payload.fromJson(jsonDecode(payloadData));
            String? role = decodedPayload.role;
            if (role == 'customer') {
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                context,
                CustomerHomeScreen.routeName,
                    (route) => false,
              );
            } else if (role == 'restaurant') {
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                context,
                RestaurantHomeScreen.routeName,
                    (route) => false,
              );
            } else if (role == 'rider') {
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                context,
                RiderHomeScreen.routeName,
                    (route) => false,
              );
            }
          } else {
            showSnackBar(context, 'Error: Token was null');
          }
          // // ignore: use_build_context_synchronously
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   CustomerHomeScreen.routeName,
          //       (route) => false,
          // );
        },
      );
    } catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if(token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if(response == true) {
        http.Response userRes = await http.get(Uri.parse('$uri/'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context,
          AuthScreen.routeName,
              (route) => false
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}