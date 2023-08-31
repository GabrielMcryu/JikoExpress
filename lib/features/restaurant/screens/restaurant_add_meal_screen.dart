import 'dart:io';

import 'package:jiko_express/common/widgets/custom_button.dart';
import 'package:jiko_express/common/widgets/custom_textfield.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/constants/utils.dart';
import 'package:jiko_express/features/restaurant/services/restaurant_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class RestaurantAddMealScreen extends StatefulWidget {
  static const String routeName = '/add-meal';
  const RestaurantAddMealScreen({super.key});

  @override
  State<RestaurantAddMealScreen> createState() => _RestaurantAddMealScreenState();
}

class _RestaurantAddMealScreenState extends State<RestaurantAddMealScreen> {
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final RestaurantServices restaurantServices = RestaurantServices();

  String category = 'Meals';
  List<File> images  = [];
  final _addMealFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    mealNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }

  List<String> mealCategories = [
    'Meals',
    'Beverages',
  ];

  void addMeal() {
    if (_addMealFormKey.currentState!.validate() && images.isNotEmpty) {
      restaurantServices.addMeal(
          context: context,
          name: mealNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          category: category,
          images: images,
      );
    }
  }

  void selectedImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text(
              'Add Meal',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Form(
          key: _addMealFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                  items: images.map(
                        (i) {
                      return Builder(
                        builder: (BuildContext context) => Image.file(
                          i,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 200,
                  ),
                )
                    : GestureDetector(
                  onTap: selectedImages,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_open,
                            size: 40,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Select Product Images',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: mealNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: mealCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Add',
                  onTap: addMeal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
