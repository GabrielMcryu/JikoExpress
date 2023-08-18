import 'package:flutter/material.dart';

// String uri = 'http://192.168.100.3:3000';
String uri = 'http://192.168.83.133:3000';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
      colors: [
        Color.fromARGB(255, 247, 103, 7),
        Color.fromARGB(255, 255, 146, 43),
      ],
    stops: [0.5, 1.0]
  );
  
  static const secondaryColor = Color.fromRGBO(240, 62, 62, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.yellow[500]!;
  static const unselectedNavBarColor = Colors.black87;
}