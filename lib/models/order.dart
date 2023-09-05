import 'dart:convert';

import 'package:jiko_express/models/meal.dart';

class Order {
  final String id;
  final List<Meal> meals;
  final List<int> quantity;
  final String address;
  final String userId;
  final String? restaurantId;
  final String? riderId;
  final int orderedAt;
  final int status;
  final double totalPrice;
  Order({
    required this.id,
    required this.meals,
    required this.quantity,
    required this.address,
    required this.userId,
    this.restaurantId,
    this.riderId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meals': meals.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'restaurantId': restaurantId,
      'riderId': riderId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id']?? '',
      meals: List<Meal>.from(
        map['meals']?.map((x) => Meal.fromMap(x['meal']))),
      quantity: List<int>.from(
        map['meals']?.map(
            (x) => x['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      restaurantId: map['restaurantId'] ?? '',
      riderId: map['riderId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}