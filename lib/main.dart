import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/AuthScreen.dart';
import 'Config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Store/StoreHome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcomApp.auth = FirebaseAuth.instance;
  EcomApp.sharedPreferences = await SharedPreferences.getInstance();
  EcomApp.firestore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ecom-flutter',
            theme: ThemeData(
                accentColor: Colors.deepPurpleAccent,
                primaryColor: Colors.blueAccent),
            home: SplashScreen(),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() async {
    super.initState();

    displaySplash();
  }

  displaySplash() {
    Timer(Duration(seconds: 5), () async {
      if (await EcomApp.auth.currentUser != null) {
        Route route = MaterialPageRoute(builder: (_) => StoreHomeScreen());
        Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (_) => AuthScreen());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.redAccent],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("welcome"),
            SizedBox(height: 20.0),
            Text(
              "ecom-app",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
