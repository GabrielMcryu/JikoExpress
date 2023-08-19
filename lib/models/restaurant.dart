import 'dart:convert';

import 'rating.dart';

class Restaurant {
  final String id;
  final String userId;
  final String name;
  final List<Rating>? rating;

  Restaurant({
    required this.id,
    required this.userId,
    required this.name,
    required this.rating,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'rating': rating,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
        id: map['_id'] ?? '',
        userId: map['userId'] ?? '',
        name: map['name'] ?? '',
        rating: map['ratings'] != null
            ? List<Rating>.from(
          map['ratings']?.map(
                (x) => Rating.fromMap(x),
          ),
        )
            :null
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));
}