import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Models/item.dart';
import 'package:ecom/Store/cartScreen.dart';
import 'package:ecom/Widgets/appDrawer.dart';
import 'package:ecom/Widgets/loadingWidget.dart';
import 'package:ecom/Widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:ecom/Counters/cartItemCounter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("items")
                  .limit(15)
                  .orderBy("publishDate", descending: true)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          ItemModel model = ItemModel.fromJson(
                              dataSnapshot.data.docs[index].data());
                          return sourceInfo(model, context);
                        },
                        itemCount: dataSnapshot.data.docs.length,
                      );
              },
            )
          ],
        ),
        // body: Text("hello"),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    splashColor: Colors.green,
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: 50.0,
        child: Row(
          children: [
            Image.network(model.thumbnailUrl, width: 140.0, height: 140.0),
            SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            model.title,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            model.shortInfo,
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.yellow,
                        ),
                        alignment: Alignment.topLeft,
                        width: 40.0,
                        height: 43.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "50%",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "OFF",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Row(
                              children: [
                                Text(
                                  "Original Price: ₹",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text(
                                  (model.price + model.price).toString(),
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Row(
                              children: [
                                Text(
                                  "New Price: ",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                Text(
                                  "₹",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.red),
                                ),
                                Text(
                                  (model.price).toString(),
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //TODO: to implement the cart Item remove feaure
                  Flexible(
                    child: Container(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
