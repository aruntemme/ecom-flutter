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
      backgroundColor: Color(0xFFE4F3FF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          title: Text(
            "Shopy",
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: Container(),
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
      body: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AdminOrders());
                    Navigator.push(context, route);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 250,
                    width: MediaQuery.of(context).size.width / 2.16,
                    child: Center(
                        child: Text(
                      "Order Requests",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Color(
                            0xFF000000,
                          )),
                    )),
                  ),
                ),
                // SizedBox(width: MediaQuery.of(context).size.width / 28),
                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AdminOrders());
                    Navigator.push(context, route);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 250,
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Center(
                        child: Text(
                      "Products",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Color(
                            0xFF000000,
                          )),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => print("click"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
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
