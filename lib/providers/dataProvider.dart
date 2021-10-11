import 'package:covid/models/dependent.dart';
import 'package:flutter/cupertino.dart';

class DataProvider extends ChangeNotifier {
  List<DependentData> dependents = [];

  List<DependentData> get getDependents => dependents;

  set setDependents(List<DependentData> value) {
    dependents = value;
    notifyListeners();
  }
}
