import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_app/Admin/adminExports.dart';
import 'package:e_shop_app/Widgets/widgetsExports.dart';
import 'package:e_shop_app/home.dart';
import 'package:e_shop_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);
  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;

  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final TextEditingController _priceTextEditingController =
      TextEditingController();
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _shortInfoTextEditingController =
      TextEditingController();

  String? productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _imageFile == null
        ? displayAdminHomeScreen()
        : displayAdminUploadFormScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.lightGreenAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.border_color,
            color: Colors.white,
          ),
          onPressed: () {
            Route route =
                MaterialPageRoute(builder: (context) => AdminShiftOrders());
            Navigator.pushReplacement(context, route);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => const SplashScreen());
              Navigator.pushReplacement(context, route);
            },
            child: const Text(
              'LogOut',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink, Colors.lightGreenAccent],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shop_2,
              color: Colors.white,
              size: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.green)),
                child: const Text(
                  'Add New Items',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () => takeImage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(mcontext) {
    return showDialog<void>(
      context: mcontext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Item Image',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: const Text(
                    'Capture with Camera',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {
                    capturePhotoWithCamera();
                  },
                ),
                ListTile(
                  title: const Text(
                    'Select from Gallery',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {
                    pickPhotoFromGallery();
                  },
                ),
                ListTile(
                  title: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  File? _imageFile;
  Future<void> capturePhotoWithCamera() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 600.0, maxWidth: 970.0);
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  pickPhotoFromGallery() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  displayAdminUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.lightGreenAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              clearFormInfo();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AdminSignInPage(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'New Product',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
            child: const Text(
              'Add',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            uploading ? circularProgress() : const Text(''),
            Container(
              height: 230.0,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(_imageFile!), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
              width: 250.0,
              child: TextField(
                controller: _shortInfoTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Short Info',
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                  prefixIcon:
                      Icon(Icons.perm_device_information, color: Colors.pink),
                ),
              ),
            ),
            const Divider(color: Colors.pink),
            Container(
              width: 250.0,
              child: TextField(
                controller: _titleTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                  prefixIcon:
                      Icon(Icons.perm_device_information, color: Colors.pink),
                ),
              ),
            ),
            const Divider(color: Colors.pink),
            Container(
              width: 250.0,
              child: TextField(
                controller: _descriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                  prefixIcon:
                      Icon(Icons.perm_device_information, color: Colors.pink),
                ),
              ),
            ),
            const Divider(color: Colors.pink),
            Container(
              width: 250.0,
              child: TextField(
                controller: _priceTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Price',
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                  prefixIcon:
                      Icon(Icons.perm_device_information, color: Colors.pink),
                ),
              ),
            ),
            const Divider(color: Colors.pink),
          ],
        ),
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      _imageFile == null;
      _descriptionTextEditingController.clear();
      _priceTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _titleTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    String imageDownloadUrl = await uploadItemImage(_imageFile!);
    saveItemInfo(imageDownloadUrl);
  }

  Future<String> uploadItemImage(mfileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Items');
    UploadTask uploadTask =
        storageReference.child("product $productId.jpg").putFile(mfileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl) {
    final itemRef = FirebaseFirestore.instance.collection('items');
    itemRef.doc(productId).set({
      'shortInfo': _shortInfoTextEditingController.text.trim(),
      'longDescription': _descriptionTextEditingController.text.trim(),
      'price': _priceTextEditingController.text.trim(),
      'publishedDate': DateTime.now(),
      'status': 'avaliable',
      'thumbnailUrl': downloadUrl,
      'title': _titleTextEditingController.text.trim(),
    });

    setState(() {
      _imageFile == null;
      uploading = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
    });
  }

  // saveItemInfo(String downloadUrl) async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   await FirebaseFirestore.instance.collection('items').doc(user!.uid).set({
  //     'shortInfo': _shortInfoTextEditingController.text.trim(),
  //     'longDescription': _descriptionTextEditingController.text.trim(),
  //     'price': _priceTextEditingController.text.trim(),
  //     'publishedDate': DateTime.now(),
  //     'status': 'avaliable',
  //     'thumbnailUrl': downloadUrl,
  //     'title': _titleTextEditingController.text.trim(),
  //   });

  //   setState(() {
  //     _imageFile == null;
  //     uploading = false;
  //     productId = DateTime.now().millisecondsSinceEpoch.toString();
  //     _descriptionTextEditingController.clear();
  //     _titleTextEditingController.clear();
  //     _shortInfoTextEditingController.clear();
  //     _priceTextEditingController.clear();
  //   });
  // }
}
