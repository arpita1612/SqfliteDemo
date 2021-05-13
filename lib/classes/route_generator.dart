import 'package:flutter/material.dart';
import 'package:sqflite_login/pages/home.dart';
import 'package:sqflite_login/pages/login.dart';
import 'package:sqflite_login/pages/register.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());

      case '/home':
        return MaterialPageRoute(
          builder: (context) => Home(),
        );

      case '/register':
        return MaterialPageRoute(
          builder: (context) => Register(),
        );
    }
  }
}
