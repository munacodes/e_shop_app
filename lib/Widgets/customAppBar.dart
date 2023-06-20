import 'package:e_shop_app/Store/storeExports.dart';
import 'package:e_shop_app/Counters/countersExports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  MyAppBar({required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}
