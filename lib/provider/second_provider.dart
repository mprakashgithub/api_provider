import 'package:flutter/material.dart';

class SecondProvider extends ChangeNotifier {
  String? name = "Prakash";

  String? getValue() {
    return name;
  }

  String? setValue(String v) {
    name = v;
    notifyListeners();
  }
}
