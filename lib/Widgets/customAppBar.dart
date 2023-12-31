import 'package:e_shop_app/Store/storeExports.dart';
import 'package:e_shop_app/Counters/countersExports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  MyAppBar({this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
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
      centerTitle: true,
      title: const Text(
        'e-Shop',
        style: TextStyle(
          fontSize: 55.0,
          color: Colors.white,
          fontFamily: 'Signatra',
        ),
      ),
      bottom: bottom,
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Route route = MaterialPageRoute(
                  builder: (context) => CartPage(),
                );
                Navigator.pushReplacement(context, route);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.pink,
              ),
            ),
            Positioned(
              child: Stack(
                children: [
                  const Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.green,
                  ),
                  Positioned(
                    top: 4.0,
                    bottom: 5.0,
                    right: 7.0,
                    left: 7.0,
                    child: Consumer<CartItemCounter>(
                      builder: (BuildContext context, counter, _) {
                        return Text(
                          counter.count.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}
