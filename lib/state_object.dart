import 'package:flutter/material.dart';

class StateObject extends ChangeNotifier {
  String email = '';

  void setUserEmail(value) {
    email = value;
    notifyListeners();
  }
}
