import 'package:ecom/Store/cartScreen.dart';
import 'package:ecom/Widgets/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:ecom/Counters/cartItemCounter.dart';
import 'package:provider/provider.dart';

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
                    Positioned(
                      top: 3.0,
                      bottom: 4.0,
                      child: Consumer<CartItemCounter>(
                        builder: (context, counter, _) {
                          return Text(
                            counter.count.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                    )
                  ],
                ))
              ],
            )
          ],
        ),
        drawer: AppDrawer(),
        body: Text("hello"),
      ),
    );
  }
}
