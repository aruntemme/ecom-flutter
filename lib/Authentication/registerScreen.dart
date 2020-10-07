import 'dart:io';

import 'package:ecom/Widgets/customTextField.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageurl = "";
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () => print("selected"),
            child: CircleAvatar(
              radius: _screenWidth * 0.15,
              backgroundColor: Colors.white,
              backgroundImage:
                  _imageFile == null ? null : FileImage(_imageFile),
              child: _imageFile == null
                  ? Icon(
                      Icons.add_a_photo_outlined,
                      size: _screenWidth * 0.15,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),
          SizedBox(height: 8.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameTextEditingController,
                  data: Icons.person,
                  hintText: "Name",
                  isObsecure: false,
                ),
                CustomTextField(
                  controller: _emailTextEditingController,
                  data: Icons.alternate_email_sharp,
                  hintText: "Email",
                  isObsecure: false,
                ),
                CustomTextField(
                  controller: _passwordTextEditingController,
                  data: Icons.lock_outline_sharp,
                  hintText: "Password",
                  isObsecure: true,
                ),
                CustomTextField(
                  controller: _cPasswordTextEditingController,
                  data: Icons.lock_outline_sharp,
                  hintText: "Name",
                  isObsecure: true,
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: () => ("clicked"),
            color: Colors.greenAccent,
            child: Text(
              "Register",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            height: 4.0,
            width: _screenWidth * 0.8,
            color: Colors.green,
          ),
          SizedBox(height: 15.0)
        ],
      ),
    ));
  }
}
