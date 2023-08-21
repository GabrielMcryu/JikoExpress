import 'package:jiko_express/router.dart';

import 'constants/global_variables.dart';
import 'features/auth/services/auth_service.dart';
import 'features/auth/services/auth_service.dart';
import 'features/auth/screens/customer_auth_screen.dart';
import 'features/auth/screens/auth_screen.dart';

import 'providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider(),)
    ],
    child: const MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

@override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jiko Express',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          )
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthScreen()
    );
  }
}


