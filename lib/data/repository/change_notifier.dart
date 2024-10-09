
import 'package:flutter/material.dart';

class SelectedTag extends ChangeNotifier {
  String _tag = "";

  String get tag => _tag;

  String getTag(){
    return _tag;
  }

  void select(String newTag) {
    _tag = newTag;
    notifyListeners();
  }
}

class SelectedDate extends ChangeNotifier {
  DateTime? _date;

  DateTime? get date => _date;

  void select(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }
}

class SelectedStringDate extends ChangeNotifier {
  String _date = "Today";

  String get date => _date;

  String getDate(){
    return _date;
  }

  void select(String newDate) {
    _date = newDate;
    notifyListeners();
  }
}