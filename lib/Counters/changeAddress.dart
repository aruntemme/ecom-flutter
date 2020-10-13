import 'package:flutter/foundation.dart';

class ChangeAddress with ChangeNotifier {
  int _counter = 0;
  int get count => _counter;
  displayResult(int v) {
    _counter = v;
    notifyListeners();
  }
}
