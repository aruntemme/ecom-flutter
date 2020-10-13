import 'package:ecom/Store/StoreHome.dart';
import 'package:flutter/material.dart';
import 'package:ecom/Widgets/searchBox.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "SEARCH",
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
            fontFamily: "GoogleSans",
          ),
        ),
        leading: GestureDetector(
          child: Icon(MdiIcons.arrowLeft),
          onTap: () {
            Route route = MaterialPageRoute(builder: (c) => StoreHomeScreen());
            Navigator.pushReplacement(context, route);
          },
        ),
      ),
      body: Hero(
        tag: "searchBar",
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
          ),
          alignment: Alignment.center,
          height: 80.0,
          child: Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              child: TextField(
                autofocus: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle:
                      TextStyle(color: Colors.blueGrey[300], fontSize: 16),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                  suffixIcon: Material(
                    color: Colors.blue,
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
