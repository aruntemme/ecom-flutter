import 'package:ecom/Store/cartScreen.dart';
import 'package:flutter/material.dart';

class StoreHomeScreen extends StatefulWidget {
  @override
  _StoreHomeScreenState createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "SHOP",
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
              fontFamily: "GoogleSans",
            ),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => CartScreen());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Positioned(
                    child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1_outlined,
                      size: 20.0,
                      color: Colors.yellow,
                    ),
                  ],
                ))
              ],
            )
          ],
        ),
        body: Text("hello"),
      ),
    );
  }
}
