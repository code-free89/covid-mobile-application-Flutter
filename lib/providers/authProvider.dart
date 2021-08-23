import 'package:covid/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  late User _user;
  UserData _userData = UserData();

  User get user => _user;
  UserData get userData => _userData;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  set userData(UserData value) {
    _userData = value;
    notifyListeners();
  }
}
