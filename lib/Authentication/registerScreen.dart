import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/DialogBox/errorDialog.dart';
import 'package:ecom/DialogBox/loadingDialog.dart';
import 'package:ecom/Store/StoreHome.dart';
import 'package:ecom/Widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecom/Config/config.dart';

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
  PickedFile _imageFile;

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
            onTap: () => _selectAndPickImage(),
            child: CircleAvatar(
              radius: _screenWidth * 0.15,
              backgroundColor: Colors.white,
              backgroundImage:
                  _imageFile == null ? null : FileImage(File(_imageFile.path)),
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
            onPressed: () {
              uploadAndSaveImage();
            },
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

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Please select an Image.",
            );
          });
    } else {
      _passwordTextEditingController.text ==
              _cPasswordTextEditingController.text
          ? _emailTextEditingController.text.isNotEmpty &&
                  _passwordTextEditingController.text.isNotEmpty &&
                  _cPasswordTextEditingController.text.isNotEmpty &&
                  _nameTextEditingController.text.isNotEmpty
              ? uploadToStorage()
              : displayDialog("Please fill up the registeration form.")
          : displayDialog("Password do not match.");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(message: msg);
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating, Please wait...",
          );
        });

    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask storageUploadTask =
        storageReference.putFile(File(_imageFile.path));

    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageurl = urlImage;

      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    User firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(message: error.message.toString());
          });
    });

    if (firebaseUser != null) {
      saveUserInfotoFireStore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => StoreHomeScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  saveUserInfotoFireStore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.trim(),
      "url": userImageurl,
    });

    await EcomApp.sharedPreferences.setString(EcomApp.userUID, fUser.uid);
    await EcomApp.sharedPreferences.setString(EcomApp.userEmail, fUser.email);
    await EcomApp.sharedPreferences
        .setString(EcomApp.userName, _nameTextEditingController.text);
    await EcomApp.sharedPreferences
        .setString(EcomApp.userAvatarUrl, userImageurl);
    await EcomApp.sharedPreferences
        .setStringList(EcomApp.userCartList, ["garbageValue"]);
  }
}
