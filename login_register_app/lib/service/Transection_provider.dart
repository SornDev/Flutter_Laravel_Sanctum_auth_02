import 'package:flutter/material.dart';
import 'package:login_register_app/model/Transection.dart';

class TransectionProvider extends ChangeNotifier {
  List<Transection> transections = [];

  List<Transection> getTransection() {
    return transections;
  }

  addTransection(Transection statement) {
    transections.insert(0, statement);
    notifyListeners();
  }

  //  List<Transection> get getTransection => transections;
}
