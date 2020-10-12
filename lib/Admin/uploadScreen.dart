import 'dart:io';
import 'package:ecom/Admin/adminOrder.dart';
import 'package:ecom/Authentication/authScreen.dart';
import 'package:ecom/Widgets/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  PickedFile file;
  TextEditingController _descriptionTextEditiongController =
      TextEditingController();
  TextEditingController _priceTextEditiongController = TextEditingController();
  TextEditingController _titleTextEditiongController = TextEditingController();
  TextEditingController _shortInfoTextEditiongController =
      TextEditingController();
  TextEditingController _categoryTextEditiongController =
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
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                onPressed: () => print("added"),
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
                    image: DecorationImage(
                        image: FileImage(File(file.path)), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0)),
          ListTile(
            leading: Icon(MdiIcons.informationOutline, color: Colors.red),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _shortInfoTextEditiongController,
                decoration: InputDecoration(
                    hintText: "short info",
                    hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(color: Colors.black),
          ListTile(
            leading: Icon(MdiIcons.informationOutline, color: Colors.red),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _titleTextEditiongController,
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(color: Colors.black),
          ListTile(
            leading: Icon(MdiIcons.informationOutline, color: Colors.red),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _descriptionTextEditiongController,
                decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(color: Colors.black),
          ListTile(
            leading: Icon(MdiIcons.informationOutline, color: Colors.red),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _priceTextEditiongController,
                decoration: InputDecoration(
                    hintText: "Price",
                    hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(color: Colors.black),
          ListTile(
            leading: Icon(MdiIcons.informationOutline, color: Colors.red),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _categoryTextEditiongController,
                decoration: InputDecoration(
                    hintText: "Category",
                    hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(color: Colors.black),
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
      _categoryTextEditiongController.clear();
      _shortInfoTextEditiongController.clear();
    });
  }
}
