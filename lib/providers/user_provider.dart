import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    phoneNumber: '',
    address: '',
    role: '',
    token: '',
  );

  User get user => user;

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}