class Payload {
  String? id;
  String? role;
  int? iat;

  Payload({this.id, this.role, this.iat});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      id: json['id'],
      role: json['role'],
      iat: json['iat'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['role'] = role;
    data['iat'] = iat;
    return data;
  }
}