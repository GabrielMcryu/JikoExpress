import 'package:jiko_express/features/customer/services/customer_services_screen.dart';
import 'package:jiko_express/models/meal.dart';
import 'package:jiko_express/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final CustomerServices customerServices = CustomerServices();

  void increaseQuantity(Meal meal) {
    customerServices.addToCart(
        context: context,
        meal: meal
    );
  }

  void decreaseQuantity(Meal meal) {
    customerServices.removeFromCart(
        context: context,
        meal: meal
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealCart = context.watch<UserProvider>().user.cart[widget.index];
    final meal = Meal.fromMap(mealCart['meal']);
    final quantity = mealCart['quantity'];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                meal.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 125,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      meal.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Kshs: ${meal.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.black12,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => decreaseQuantity(meal),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(
                        quantity.toString(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => increaseQuantity(meal),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
