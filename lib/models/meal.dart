import 'dart:convert';

class Meal {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final List<String> images;
  final String category;
  final double price;

  Meal({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.images,
    required this.category,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'description': description,
      'images': images,
      'category': category,
      'price': price,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
        id: map['_id'] ?? '',
        restaurantId: map['restaurantId'] ?? '',
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meal.fromJson(String source) =>
      Meal.fromMap(json.decode(source));
}