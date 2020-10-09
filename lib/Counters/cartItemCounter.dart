import 'package:flutter/foundation.dart';
import 'package:ecom/Config/config.dart';

class CartItemCounter extends ChangeNotifier {
  int _counter =
      EcomApp.sharedPreferences.getStringList(EcomApp.userCartList).length - 1;
  int get count => _counter;
}
