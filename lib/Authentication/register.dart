import 'dart:io';
import 'package:e_shop_app/Widgets/widgetsExports.dart';
import 'package:e_shop_app/DialogBox/dialogBoxExports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storeExports.dart';
import 'package:e_shop_app/Config/config.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();
  // _cPasswordTextEditingController means Confirm Password TextEditingController

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? userImageUrl = '';
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: _selectAndClickImage,
              child: CircleAvatar(
                radius: _screenWidth = 60.0,
                backgroundColor: Colors.white,
                backgroundImage:
                    _imageFile == null ? null : FileImage(_imageFile!),
                child: _imageFile == null
                    ? Icon(
                        Icons.add_a_photo,
                        size: _screenWidth = 60.0,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameTextEditingController,
                    data: Icons.person,
                    hintText: 'Name',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: 'Email',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    hintText: 'Password',
                    isObsecure: true,
                  ),
                  CustomTextField(
                    controller: _cPasswordTextEditingController,
                    data: Icons.person,
                    hintText: 'Confirm Password',
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                uploadAndSaveImage();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.pink,
                ),
                // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //   RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth = 300.0,
              color: Colors.pink,
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAndClickImage() async {
    _imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery) as File?;
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorAlertDialog(message: 'Please Select an Image');
        },
      );
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  File? _pickedImage;
  // PickedFile? _image;
  Future<void> _getImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final _image = await picker.pickImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }
}
