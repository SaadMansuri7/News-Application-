import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  void setLoading(bool value) {
    _isBusy = value;
    notifyListeners();
  }
}
