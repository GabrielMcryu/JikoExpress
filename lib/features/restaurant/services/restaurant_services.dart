import 'dart:convert';
import 'dart:io';
import 'package:jiko_express/constants/error_handling.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/constants/utils.dart';
import 'package:jiko_express/models/meal.dart';
import 'package:jiko_express/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class RestaurantServices {
  final cloudName = dotenv.env['CLOUD_NAME'];
  final uploadPreset = dotenv.env['UPLOAD_PRESET'];

  void addMeal({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('$cloudName', '$uploadPreset');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Meal meal = Meal(
        name: name,
        description: description,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/restaurant/add-meal'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: meal.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.pop(context);
        },
      );

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all meals
  Future<List<Meal>> fetchRestaurantMeals(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Meal> mealList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/restaurant/get-meals'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for(int i = 0; i < jsonDecode(res.body).length; i++) {
              mealList.add(
                Meal.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
      );

    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return mealList;
  }

  void deleteMeal({
    required BuildContext context,
    required Meal meal,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/restaurant/delete-meal'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': meal.id,
        })
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}