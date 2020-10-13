import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Counters/cartItemCounter.dart';
import 'package:ecom/Counters/changeAddress.dart';
import 'package:ecom/Counters/itemQuantity.dart';
import 'package:ecom/Counters/totalMoney.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authScreen.dart';
import 'Config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Store/storeHome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EcomApp.auth = FirebaseAuth.instance;
  EcomApp.sharedPreferences = await SharedPreferences.getInstance();
  EcomApp.firestore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => ItemQuantity()),
        ChangeNotifierProvider(create: (c) => ChangeAddress()),
        ChangeNotifierProvider(create: (c) => TotalMoney()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ecom-flutter',
        theme: ThemeData(
            iconTheme: IconThemeData(color: Colors.black),
            accentColor: Colors.deepPurpleAccent,
            fontFamily: "GoogleSans",
            primaryColor: Colors.black),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    displaySplash();
  }

  displaySplash() async {
    Timer(Duration(seconds: 4), () async {
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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "welcome",
              style: TextStyle(fontSize: 25.0, color: Colors.black),
            ),
            SizedBox(height: 20.0),
            Text(
              "Online Store",
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Image.asset(
              "assets/images/giphy.gif",
              height: 250.0,
              width: 250.0,
            ),
          ],
        ),
      ),
    );
  }
}
