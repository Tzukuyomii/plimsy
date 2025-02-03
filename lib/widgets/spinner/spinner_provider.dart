import 'package:flutter/material.dart';

class SpinnerProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void showSpinner() {
    _isLoading = true;
    notifyListeners();
    print("BOOL  SHOW SPINNER $isLoading");
  }

  void hideSpinner() {
    _isLoading = false;
    notifyListeners();
    print("BOOL  HIDE SPINNER $isLoading");
  }
}
