import 'package:ecom/Address/addAddress.dart';
import 'package:ecom/Authentication/authScreen.dart';
import 'package:ecom/Config/config.dart';
import 'package:ecom/Store/StoreHome.dart';
import 'package:ecom/Store/cartScreen.dart';
import 'package:ecom/Store/myOrders.dart';
import 'package:ecom/Store/searchProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60), topRight: Radius.circular(60)),
      child: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                color: Colors.black,
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      elevation: 8.0,
                      child: Container(
                        height: 160.0,
                        width: 160.0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            EcomApp.sharedPreferences
                                .getString(EcomApp.userAvatarUrl),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      EcomApp.sharedPreferences.getString(EcomApp.userName),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 30.0),
                    )
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.only(top: 1.0),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 25.0),
                      leading: Icon(Icons.home_outlined, color: Colors.black),
                      title: Text("Home",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "GoogleSans",
                              fontSize: 20.0)),
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (c) => StoreHomeScreen());
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                    Divider(height: 5),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 25.0),
                      leading: Icon(Icons.inbox_rounded, color: Colors.black),
                      title: Text("My Orders",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "GoogleSans",
                              fontSize: 20.0)),
                      onTap: () {
                        Route route =
                            MaterialPageRoute(builder: (c) => MyOrders());
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                    Divider(height: 5),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 25.0),
                      leading: Icon(Icons.shopping_cart_outlined,
                          color: Colors.black),
                      title: Text("My Cart",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "GoogleSans",
                              fontSize: 20.0)),
                      onTap: () {
                        Route route =
                            MaterialPageRoute(builder: (c) => CartScreen());
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                    Divider(height: 5),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 25.0),
                      leading: Icon(Icons.search_rounded, color: Colors.black),
                      title: Text("Search",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "GoogleSans",
                              fontSize: 20.0)),
                      onTap: () {
                        Route route =
                            MaterialPageRoute(builder: (c) => SearchProduct());
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                    Divider(height: 5),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 25.0),
                      leading:
                          Icon(Icons.add_circle_outline, color: Colors.black),
                      title: Text("Add Address",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "GoogleSans",
                              fontSize: 20.0)),
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (c) => AddAddressScreen());
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                    Divider(height: 5),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 25.0),
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text("Logout",
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: "GoogleSans",
                              fontSize: 20.0)),
                      onTap: () {
                        EcomApp.auth.signOut().then((c) {
                          Route route =
                              MaterialPageRoute(builder: (c) => AuthScreen());
                          Navigator.pushReplacement(context, route);
                        });
                      },
                    ),
                    Divider(height: 5),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
