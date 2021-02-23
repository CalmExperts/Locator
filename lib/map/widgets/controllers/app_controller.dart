import 'package:flutter/cupertino.dart';
import 'package:locator/map/bloc/map_bloc.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();

  double isHeight = 125;

  bool isModalActive = false;

  bool isColor = false;

  String isButtonCollor = '';

  int nume;

  changeModal(value) {
    isModalActive = value;
    notifyListeners();
    // print('Value passed: ${value}');
  }

  changeHeight(value) {
    isHeight = value;
    notifyListeners();
    // print('Value passed in HEIGHT: ${value}');
  }

  changeColor(value) {
    isColor = value;
    notifyListeners();
    // print('Value passed in Color: ${value}');
  }

  changeButtonColor(value) {
    // myColorz[nume].color = 0xff738f66;

    isButtonCollor = value;

    notifyListeners();
    // print('Value passed in Color: ${value}');
  }
}
