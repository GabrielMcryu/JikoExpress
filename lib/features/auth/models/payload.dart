class Payload {
  String? id;
  String? type;
  int? iat;

  Payload({this.id, this.type, this.iat});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      id: json['id'],
      type: json['type'],
      iat: json['iat'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['iat'] = iat;
    return data;
  }
}