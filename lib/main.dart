import 'dart:async';
import 'Config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  EcomApp.auth=FirebaseAuth.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ecom-flutter',
      theme: ThemeData(accentColor: Colors.deepPurpleAccent,
      primaryColor: Colors.blueAccent),
      
     home:SplashScreen(),
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
    
      @override
      Widget build(BuildContext context) {
        return Container(
           child: child,
        );
      }
    
      void displaySplash() {
        Timer(Duration(seconds: 5),() async{
          
        });
      }
}