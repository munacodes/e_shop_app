import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_app/Config/config.dart';
import 'package:e_shop_app/Counters/cartItemCounter.dart';
import 'package:e_shop_app/Counters/changeAddress.dart';
import 'package:e_shop_app/Counters/countersExports.dart';
import 'package:e_shop_app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = FirebaseFirestore.instance;
  EcommerceApp.user = FirebaseStorage.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartItemCounter()),
        ChangeNotifierProvider(create: (context) => ItemQuantity()),
        ChangeNotifierProvider(create: (context) => AddressChanger()),
        ChangeNotifierProvider(create: (context) => TotalAmount()),
      ],
      child: MaterialApp(
        title: 'e-Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
