import 'package:ecom/Store/cartScreen.dart';
import 'package:ecom/Widgets/appDrawer.dart';
import 'package:ecom/Widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:ecom/Counters/cartItemCounter.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(0),
              ),
            ),
            backgroundColor: Colors.black,
            title: Text(
              "SHOP",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontFamily: "GoogleSans",
              ),
            ),
            leading: IconButton(
              icon: Icon(
                MdiIcons.sortVariant,
                size: 28.0,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            centerTitle: true,
            actions: [
              Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                        icon: Icon(MdiIcons.shoppingOutline),
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
                              Icons.brightness_1,
                              size: 20.0,
                              color: Colors.red[600],
                            ),
                            Positioned(
                              top: 2,
                              bottom: 4.0,
                              left: 5.8,
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
                ],
              ),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate())
          ],
        ),
        // body: Text("hello"),
      ),
    );
  }
}
