import 'dart:convert';

class Rider {
  final String? id;
  final String? userId;
  final String? restaurantId;
  final String drivingLicenseNumber;
  final String status;

  Rider({
    this.id,
    this.userId,
    this.restaurantId,
    required this.drivingLicenseNumber,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'drivingLicenseNumber': drivingLicenseNumber,
      'status': status,
    };
  }

  factory Rider.fromMap(Map<String, dynamic> map) {
    return Rider(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      restaurantId: map['restaurantId'] ?? '',
      drivingLicenseNumber: map['drivingLicenseNumber'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Rider.fromJson(String source) =>
      Rider.fromMap(json.decode(source));
}