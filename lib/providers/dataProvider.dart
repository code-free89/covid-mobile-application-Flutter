import 'package:covid/models/checkin-history.dart';
import 'package:covid/models/dependent.dart';
import 'package:flutter/cupertino.dart';

class DataProvider extends ChangeNotifier {
  List<DependentData> dependents = [];
  List<CheckInHistoryData> histories = [];

  List<DependentData> get getDependents => dependents;
  List<CheckInHistoryData> get getHistories => histories;

  set setDependents(List<DependentData> value) {
    dependents = value;
    notifyListeners();
  }

  set setHistories(List<CheckInHistoryData> value) {
    histories = value;
    notifyListeners();
  }
}
