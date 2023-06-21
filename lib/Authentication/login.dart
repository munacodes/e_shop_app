import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_app/Admin/adminExports.dart';
import 'package:e_shop_app/Widgets/widgetsExports.dart';
import 'package:e_shop_app/DialogBox/dialogBoxExports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../Store/storeExports.dart';
import 'package:e_shop_app/Config/config.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: const Image(
                image: AssetImage('assets/images/login.png'),
                height: 240.0,
                width: 240.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Login to your account',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _emailTextEditingController.text.isNotEmpty &&
                        _passwordTextEditingController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                        context: context,
                        builder: (c) {
                          return const ErrorAlertDialog(
                              message: 'Please write email and password.');
                        },
                      );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.pink,
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth = 300.0,
              color: Colors.pink,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminSignInPage(),
                ),
              ),
              icon: const Icon(
                Icons.nature_people,
                color: Colors.pink,
              ),
              label: const Text(
                'I\'m Admin',
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async {
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingAlertDialog(
            message: 'Authenticating, Please wait....');
      },
    );
    User? user = FirebaseAuth.instance.currentUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((authUser) {
      user = authUser.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (contex) {
          return ErrorAlertDialog(message: error.message.toString());
        },
      );
    });
    if (user != null) {
      readData(user!).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (context) => StoreHome());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future<void> readData(User user) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((dataSnapshot) async {
      await EcommerceApp.sharedPreferences!
          .setString('uid', dataSnapshot.data()![EcommerceApp.userUID]);
      await EcommerceApp.sharedPreferences!.setString(
          EcommerceApp.userEmail, dataSnapshot.data()![EcommerceApp.userEmail]);
      await EcommerceApp.sharedPreferences!.setString(
          EcommerceApp.userName, dataSnapshot.data()![EcommerceApp.userName]);
      await EcommerceApp.sharedPreferences!.setString(
          EcommerceApp.userAvatarUrl,
          dataSnapshot.data()![EcommerceApp.userAvatarUrl]);
      List<String> cartList =
          dataSnapshot.data()![EcommerceApp.userCartList].cast<String>();
      await EcommerceApp.sharedPreferences!
          .setStringList(EcommerceApp.userCartList, cartList);
    });
  }
}
