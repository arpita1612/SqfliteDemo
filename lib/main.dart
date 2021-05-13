import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_login/generated/l10n.dart';
import 'package:sqflite_login/pages/home.dart';
import 'package:sqflite_login/pages/login.dart';
import 'classes/route_generator.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences prefs;
  bool check = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      check = prefs.getString('UserName') == null ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      title: 'Login App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: check ? Home() : Login(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
