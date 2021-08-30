import 'package:covid/models/user.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  UserData _userData = UserData();
  String _currentDateTime = "As of 24 Aug 2021, 8:34 AM";

  UserData get userData => _userData;
  String get currentDateTime => _currentDateTime;

  set userData(UserData value) {
    _userData = value;
    notifyListeners();
  }

  set currentDateTime(String value) {
    _currentDateTime = value;
    notifyListeners();
  }
}
