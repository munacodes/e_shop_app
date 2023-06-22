import 'package:flutter/foundation.dart';
import 'package:e_shop_app/Config/config.dart';

class CartItemCounter extends ChangeNotifier {
  final int _counter = EcommerceApp.sharedPreferences!
          .getStringList(EcommerceApp.userCartList)!
          .length -
      1;

  int get count => _counter;

  Future<void> displayResult() async {
    final int _counter = EcommerceApp.sharedPreferences!
            .getStringList(EcommerceApp.userCartList)!
            .length -
        1;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
