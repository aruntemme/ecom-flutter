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
              color: Colors.white)
        ],
      ),
    );
  }
}
