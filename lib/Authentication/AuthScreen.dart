import 'package:ecom/Authentication/loginScreen.dart';
import 'package:ecom/Authentication/registerScreen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.black
                // gradient: LinearGradient(
                //   colors: [Color(0xffec008c), Color(0xfffc6767)],
                //   begin: const FractionalOffset(0.0, 0.0),
                //   end: const FractionalOffset(1.0, 0.0),
                //   stops: [0.0, 1.0],
                //   tileMode: TileMode.clamp,
                // ),
                ),
          ),
          title: Text(
            "Shopy",
            style: TextStyle(
                fontSize: 40.0, color: Colors.white, fontFamily: "GoogleSans"),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                text: "Login",
              ),
              Tab(
                icon: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                text: "Register",
              )
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000000),
                Color(0xFFFFFFFF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: TabBarView(
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
