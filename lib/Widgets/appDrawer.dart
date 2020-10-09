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
    return Drawer(
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
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text("Home", style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => StoreHomeScreen());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(color: Colors.black, height: 10.0, thickness: 5.0),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.black),
                  title:
                      Text("My Orders", style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) => MyOrders());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(color: Colors.black, height: 10.0, thickness: 5.0),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text("My Cart", style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => CartScreen());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(color: Colors.black, height: 10.0, thickness: 5.0),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text("Search", style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => SearchProduct());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(color: Colors.black, height: 10.0, thickness: 5.0),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text("Add Address",
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AddAddressScreen());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(color: Colors.black, height: 10.0, thickness: 5.0),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text("Logout", style: TextStyle(color: Colors.black)),
                  onTap: () {
                    EcomApp.auth.signOut().then((c) {
                      Route route =
                          MaterialPageRoute(builder: (c) => AuthScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
                Divider(color: Colors.black, height: 10.0, thickness: 5.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
