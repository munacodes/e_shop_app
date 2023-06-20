import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_app/Counters/countersExports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenticationExports.dart';
import 'package:e_shop_app/Config/config.dart';
import 'Counters/countersExports.dart';
import 'Store/storeExports.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
          "Welcome to Flutter Firetore eCommerce Course by Coding Cafe.",
          style: TextStyle(color: Colors.green, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
