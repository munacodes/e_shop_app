import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_app/Store/storeExports.dart';
import 'package:e_shop_app/Counters/countersExports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop_app/Config/config.dart';
import '../Widgets/widgetsExports.dart';
import '../Models/modelsExports.dart';

double? width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color? background, removeCartFunction}) {
  return InkWell();
}

Widget card({Color primaryColor = Colors.redAccent, String? imgPath}) {
  return Container();
}

void checkItemInCart(String productID, BuildContext context) {}
