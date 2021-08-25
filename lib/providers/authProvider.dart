import 'package:covid/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  UserData _userData = UserData();

  UserData get userData => _userData;

  set userData(UserData value) {
    _userData = value;
    notifyListeners();
  }
}
