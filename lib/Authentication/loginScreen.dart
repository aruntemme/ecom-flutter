import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Admin/adminSignIn.dart';
import 'package:ecom/Config/config.dart';
import 'package:ecom/DialogBox/errorDialog.dart';
import 'package:ecom/DialogBox/loadingDialog.dart';
import 'package:ecom/Store/StoreHome.dart';
import 'package:ecom/Widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditingController =
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
              "Login to your account",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
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
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              _emailTextEditingController.text.isNotEmpty &&
                      _passwordTextEditingController.text.isNotEmpty
                  ? loginUser()
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
          SizedBox(height: 15.0),
          FlatButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminSignInPage())),
              icon: Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.white,
              ),
              label: Text(
                "I'm Admin",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    ));
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(message: "Logging in, please wait...");
        });
    User firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(message: error.message.toString());
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => StoreHomeScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future<void> readData(User fUser) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await EcomApp.sharedPreferences
          .setString("uid", dataSnapshot.data()[EcomApp.userUID]);
      await EcomApp.sharedPreferences
          .setString(EcomApp.userEmail, dataSnapshot.data()[EcomApp.userEmail]);
      await EcomApp.sharedPreferences
          .setString(EcomApp.userName, dataSnapshot.data()[EcomApp.userName]);
      await EcomApp.sharedPreferences.setString(
          EcomApp.userAvatarUrl, dataSnapshot.data()[EcomApp.userAvatarUrl]);
      List<String> cartList =
          dataSnapshot.data()[EcomApp.userCartList].cast<String>();
      await EcomApp.sharedPreferences
          .setStringList(EcomApp.userCartList, cartList);
    });
  }
}
