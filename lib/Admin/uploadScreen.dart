import 'package:ecom/Admin/adminOrder.dart';
import 'package:ecom/Authentication/authScreen.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return displayAdminHomeScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      backgroundColor: Color(0XFF4E55AF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          title: Text(
            "Shopy",
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.border_color, color: Colors.black),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (c) => AdminOrders());
                Navigator.pushReplacement(context, route);
              }),
          actions: [
            FlatButton(
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (c) => AuthScreen());
                  Navigator.pushReplacement(context, route);
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.red,
                )),
          ],
        ),
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => print("click"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        icon: Icon(Icons.add),
        elevation: 2.0,
        label: Text("Add new Item"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
