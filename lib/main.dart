import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Welcome.dart';
import 'Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Welcome.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: FutureBuilder(
        future: _checkFirstTime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data == true ? FirstPage() : HomeP();
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<bool> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime') ?? true;

    if (firstTime) {
      // Set the flag to false after showing the WelcomePage for the first time
      await prefs.setBool('firstTime', false);
    }

    return firstTime;
  }
}
