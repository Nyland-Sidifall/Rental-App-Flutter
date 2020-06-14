import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Screens/login_page.dart';
import 'package:flutterrentalapp/Screens/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {
        //For connecting multiple scenes together to the main page
        login_page.routeName: (context) => login_page(),
        signup_page.routeName: (context) => signup_page(),
        guest_home_page.routeName: (context) => guest_home_page(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    Timer(Duration(seconds: 2), (){
      Navigator.pushNamed(context, login_page.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.hotel,
              size: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Welcome to ${AppConstants.appName}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
