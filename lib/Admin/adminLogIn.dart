import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Admin/uploadScreen.dart';
import 'package:ecom/Authentication/authScreen.dart';
import 'package:ecom/DialogBox/errorDialog.dart';
import 'package:ecom/Widgets/customTextField.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.black),
        ),
        title: Text(
          "Shopy",
          style: TextStyle(
              fontSize: 30.0, color: Colors.white, fontFamily: "GoogleSans"),
        ),
        centerTitle: true,
      ),
      body: AdminLoginPage(),
    );
  }
}

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _adminIDTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Container(
      child: Column(
        children: [
          Container(
            child: Icon(
              Icons.home_filled,
              // height: 240.0,
              // width: 240.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Login to your Admin account",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _adminIDTextEditingController,
                  data: Icons.alternate_email_sharp,
                  hintText: "Admin ID",
                  isObsecure: false,
                ),
                CustomTextField(
                  controller: _passwordTextEditingController,
                  data: Icons.lock_outline_sharp,
                  hintText: "Password",
                  isObsecure: true,
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              _adminIDTextEditingController.text.isNotEmpty &&
                      _passwordTextEditingController.text.isNotEmpty
                  ? loginAdmin()
                  : showDialog(
                      context: context,
                      builder: (c) {
                        return ErrorAlertDialog(
                            message: "please fill the field.");
                      });
            },
            color: Colors.greenAccent,
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 50.0),
          Container(
            height: 4.0,
            width: _screenWidth * 0.8,
            color: Colors.green,
          ),
          SizedBox(height: 50.0),
          FlatButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AuthScreen())),
              icon: Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.white,
              ),
              label: Text(
                "I'm not Admin",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    ));
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("admins").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["id"] != _adminIDTextEditingController.text.trim()) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Your id is incorrect")));
        } else if (result.data()["password"] !=
            _passwordTextEditingController.text.trim()) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Your password is incorrect")));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Welcome Admin, " + result.data()["name"])));

          setState(() {
            _adminIDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });
          Route route = MaterialPageRoute(builder: (c) => UploadScreen());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
