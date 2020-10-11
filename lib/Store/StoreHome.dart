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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        key: _scaffoldKey,
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
          leading: Container(),
          centerTitle: true,
          actions: [
            Row(
              children: [
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
                      right: 6.0,
                      top: 4.0,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.brightness_1_outlined,
                            size: 20.0,
                            color: Colors.red,
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
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    size: 35.0,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ],
            ),
          ],
        ),
        endDrawer: AppDrawer(),
        // body: Text("hello"),
      ),
    );
  }
}
