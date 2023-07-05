import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EcommerceApp {
  static const String appName = 'e-Shop'; // app name

  static SharedPreferences? sharedPreferences;
  static FirebaseStorage? user; // accessing firebase storage
  static FirebaseAuth? auth; // accessing firebase authentication
  static FirebaseFirestore? firestore; // accessing firebase firestore cloud

  static String collectionUser = "users"; // Collection of users
  static String collectionOrders = "orders"; // Collection of orders
  static String userCartList = 'userCart'; // List of userCart
  static String subCollectionAddress =
      'userAddress'; // Collection of users Address

  static const String userName = 'name'; // user name
  static const String userEmail = 'email'; // user email
  static const String userPhotoUrl = 'photoUrl'; // user photo
  static const String userUID = 'uid'; // user uid
  static const String userAvatarUrl = 'url'; // user profile image

  static const String addressID = 'addressID'; // user address
  static const String totalAmount = 'totalAmount'; // total amount of product
  static const String productID = 'productIDs'; // each product unique id
  static const String paymentDetails = 'paymentDetails'; // deatails of payment
  static const String orderTime = 'orderTime'; // time ordered product
  static const String isSuccess = 'isSuccess'; // when an order is successful
}
