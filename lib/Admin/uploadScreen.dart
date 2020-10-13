import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Admin/adminOrder.dart';
import 'package:ecom/Authentication/authScreen.dart';
import 'package:ecom/Widgets/loadingWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  var _categories = [
    "Category",
    "Electronics",
    "Fashion - Men & Women",
    "Medical",
    "Home, Kitchen, Pets",
    "Sports, Fitness, Bags",
    "Beauty, Health, Grocery",
    "Salary"
  ];
  String _dropdownValue = "Category";

  PickedFile file;
  TextEditingController _descriptionTextEditiongController =
      TextEditingController();
  TextEditingController _priceTextEditiongController = TextEditingController();
  TextEditingController _titleTextEditiongController = TextEditingController();
  TextEditingController _shortInfoTextEditiongController =
      TextEditingController();
  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null ? displayAdminHomeScreen() : displayAdminUploadScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
            "Admin",
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          leading: Container(),
          centerTitle: true,
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AdminOrders());
                    Navigator.push(context, route);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFCCE4D7),
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
                      color: Color(0xFFE7D8DE),
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
        onPressed: () => takeImage(context),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        elevation: 2.0,
        label: Text("Add new Item"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(10)),
            title: Text(
              "Item Image",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: Text("Open Camera",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: capturewithCamera,
              ),
              SimpleDialogOption(
                child: Text("Select from Gallery",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Cancel",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  capturewithCamera() async {
    Navigator.pop(context);
    PickedFile imageFile = await ImagePicker().getImage(
        source: ImageSource.camera, maxHeight: 600.0, maxWidth: 970.0);

    setState(() {
      file = imageFile;
    });
  }

  pickPhotoFromGallery() async {
    Navigator.pop(context);
    PickedFile imageFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      file = imageFile;
    });
  }

  displayAdminUploadScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
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
            "New Product",
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(MdiIcons.menuLeftOutline), onPressed: clearFormInfo),
          actions: [
            FlatButton(
                onPressed:
                    uploading ? null : () => uploadImageAndSaveItemInfo(),
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
      body: ListView(
        children: [
          uploading ? linearProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        image: FileImage(File(file.path)), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0)),
          ListTile(
            leading: Icon(MdiIcons.informationVariant, color: Colors.blue),
            title: Container(
              width: 250.0,
              height: 58.0,
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                controller: _shortInfoTextEditiongController,
                decoration: InputDecoration(
                  hintText: "short info",
                  hintStyle: TextStyle(color: Colors.blueGrey[250]),
                  border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal),
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.white),
          ListTile(
            leading: Icon(MdiIcons.formatTitle, color: Colors.blue),
            title: Container(
              width: 250.0,
              height: 58.0,
              child: TextField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                controller: _titleTextEditiongController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.blueGrey[250]),
                  border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal),
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.white),
          ListTile(
            leading: Icon(MdiIcons.text, color: Colors.blue),
            title: Container(
              width: 250.0,
              height: 58.0,
              child: TextField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                controller: _descriptionTextEditiongController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.blueGrey[250]),
                  border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.white),
          ListTile(
            leading: Icon(MdiIcons.cash, color: Colors.blue),
            title: Container(
              width: 250.0,
              height: 58.0,
              child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                controller: _priceTextEditiongController,
                decoration: InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(color: Colors.blueGrey[250]),
                  border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.white),
          ListTile(
            leading: Icon(MdiIcons.informationVariant, color: Colors.blue),
            title: Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: Colors.white,
                  border: Border.all()),
              width: 250.0,
              height: 58.0,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  focusColor: Colors.black,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  items: _categories.map((String singleItem) {
                    return DropdownMenuItem<String>(
                        value: singleItem, child: Text(singleItem));
                  }).toList(),
                  onChanged: (String itemChosen) {
                    setState(() {
                      this._dropdownValue = itemChosen;
                    });
                  },
                  value: _dropdownValue,
                ),
              ),
            ),
          ),
          Divider(color: Colors.white),
        ],
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      file = null;
      _descriptionTextEditiongController.clear();
      _shortInfoTextEditiongController.clear();
      _titleTextEditiongController.clear();
      _dropdownValue = "";
      _shortInfoTextEditiongController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    String imageDownloadURL = await uploadItemImage(File(file.path));
    saveItemINFO(imageDownloadURL);
  }

  Future<String> uploadItemImage(mFileImage) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("items");
    StorageUploadTask uploadTask =
        storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot takeSnapshot = await uploadTask.onComplete;
    String downloadUrl = await takeSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemINFO(String downloadURL) {
    final itemsRef = FirebaseFirestore.instance.collection("items");
    itemsRef.doc(productId).set({
      "shortInfo": _shortInfoTextEditiongController.text.trim(),
      "title": _titleTextEditiongController.text.trim(),
      "category": _dropdownValue.trim(),
      "longDescription": _descriptionTextEditiongController.text.trim(),
      "publishDate": DateTime.now(),
      "price": int.parse(_priceTextEditiongController.text),
      "status": "available",
      "thumbnailUrl": downloadURL,
    });
    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().microsecondsSinceEpoch.toString();
      _dropdownValue = "Category";
      _descriptionTextEditiongController.clear();
      _shortInfoTextEditiongController.clear();
      _titleTextEditiongController.clear();
      _priceTextEditiongController.clear();
    });
  }
}
