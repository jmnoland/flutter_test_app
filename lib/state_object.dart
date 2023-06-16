import 'package:flutter/material.dart';

class StateObject extends ChangeNotifier {
  var count = 0;

  void incrementCounter() {
    count++;
    notifyListeners();
  }
}
