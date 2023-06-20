import 'package:e_shop_app/Models/modelsExports.dart';
import 'package:e_shop_app/Store/storeExports.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Widgets/widgetsExports.dart';

class SearchService {}

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => new _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(),
    );
  }
}

Widget buildResultCard(data) {
  return Card();
}
