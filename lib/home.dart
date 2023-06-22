import 'dart:async';
import 'package:e_shop_app/Authentication/authentication.dart';
import 'package:e_shop_app/Config/config.dart';
import 'package:e_shop_app/Store/storeExports.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    displaySplash();
  }

  displaySplash() {
    Timer(
      const Duration(seconds: 5),
      () async {
        if (EcommerceApp.auth!.currentUser != null) {
          Route route = MaterialPageRoute(
            builder: (_) => StoreHome(),
          );
          Navigator.pushReplacement(context, route);
        } else {
          Route route = MaterialPageRoute(
            builder: (_) => const AuthenticScreen(),
          );
          Navigator.pushReplacement(context, route);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.lightGreenAccent,
            ],
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
              Image.asset('images/welcome.png'),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'World\'s Largest & Number One Shop',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
