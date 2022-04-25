import 'package:flutter/material.dart';

class FirstProvider extends ChangeNotifier {
  int value = 0;

  int getValue() {
    return value;
  }

  int? setValue(int v) {
    value = v;
    notifyListeners();
  }
}
