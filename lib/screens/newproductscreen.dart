import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class NewProductScreen extends StatefulWidget {
  NewProductScreen({Key? key}) : super(key: key);

  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  late File _image;
  final _picker = ImagePicker();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _flavourController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink.shade700,
        //    leading: IconButton(
        //      icon:Icon(Icons.arrow_back),
        // onPressed:()=>Navigator.push( context, MaterialPageRoute( builder: (context) => HomeScreen(user: widget.user)), ).then((value) => setState(() {}))
        // )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.fromLTRB(30, 25, 30, 20),
                elevation: 8,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: Text('Product Details Form',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                          onTap: () => {_showDialog()},
                          child: Column(
                            children: [
                              Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      //image: if(_image==null){}else{AssetImage(
                                      //    'assets/images/product_null.png'),}
                                      //image: null,
                                      image: AssetImage(
                                          'assets/images/product_null.png'),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  )),
                            ],
                          )),
                      SizedBox(height: 15),
                      TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Product Name',
                            prefixIcon: Icon(Icons.mode),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.pink.shade900, width: 50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.pink.shade900, width: 2.0),
                            ),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                          controller: _flavourController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Product Flavour',
                            prefixIcon: Icon(Icons.cake),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.pink.shade900, width: 50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.pink.shade900, width: 2.0),
                            ),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Product Description',
                          prefixIcon: Icon(Icons.description),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink.shade900, width: 50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink.shade900, width: 2.0),
                          ),
                        ),
                        maxLines: 5,
                        minLines: 3,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Product Price',
                            prefixIcon: Icon(Icons.monetization_on_outlined),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.pink.shade900, width: 50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.pink.shade900, width: 2.0),
                            ),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minWidth: 150,
                          color: Colors.pink.shade900,
                          child: Text('Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          onPressed: _confirmDialog,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDialog() {
    String name = _nameController.text.toString();
    String flavour = _flavourController.text.toString();
    String description = _descriptionController.text.toString();
    String price = _priceController.text.toString();

    String base64Image = base64Encode(_image.readAsBytesSync());
    if (base64Image == null ||
        name == "" ||
        price == "" ||
        flavour == "" ||
        description == "") {
      Fluttertoast.showToast(
          msg: "Please fill in all the product's information",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink.shade50,
          textColor: Colors.black,
          fontSize: 16);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text("Add Product "),
            content: new Container(
              height: 40,
              child: Text("Are you sure you want to add this product?"),
            ),
            actions: [
              TextButton(
                  child: Text("Confirm",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addProduct(name, flavour, description, price, base64Image);
                  }),
              TextButton(
                  child: Text("Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future _pickImageFromCamera() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      maxHeight: 400,
      maxWidth: 400,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _cropImage();
  }

  _pickImageFromGallery() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _cropImage();
  }

  Future<void> _addProduct(String name, String flavour, String description,
      String price, String base64Image) async {
    http.post(
        Uri.parse("http://pyong27.com/s271147/kobeescake/php/addproduct.php"),
        body: {
          "name": name,
          "flavour": flavour,
          "description": description,
          "price": price,
          "encoded_string": base64Image,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Product successfully added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink.shade50,
            textColor: Colors.black,
            fontSize: 16);
        setState(() {
          //_image = null;
          _nameController.text = "";
          _flavourController.text = "";
          _descriptionController.text = "";
          _priceController.text = "";
        });
      } else {
        Fluttertoast.showToast(
            msg: "Product failed to be added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink.shade50,
            textColor: Colors.black,
            fontSize: 16);
      }
    });
  }

  _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.pink.shade50,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: new Container(
              alignment: Alignment.center,
              height: 90,
              width: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            icon: const Icon(Icons.photo_camera,
                                size: 25, color: Colors.black),
                            onPressed: () async => {
                                  Navigator.pop(context),
                                  _pickImageFromCamera()
                                },
                            label: Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            )),
                        //Text('Camera'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            icon: const Icon(Icons.photo,
                                size: 25, color: Colors.black),
                            onPressed: () async => {
                                  Navigator.pop(context),
                                  _pickImageFromGallery()
                                },
                            label: Text(
                              'Gallery',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
} //end newproduct
