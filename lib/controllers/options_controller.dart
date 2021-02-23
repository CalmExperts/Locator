import 'package:mobx/mobx.dart';
part 'options_controller.g.dart';

class OptionsController = _OptionsControllerBase with _$OptionsController;

abstract class _OptionsControllerBase with Store {
  @observable
  double height = 125;

  @observable
  bool isModalActive = false;

  @observable
  bool isColorActive = false;

  @observable
  int number;

  @observable
  String buttonColor = "";

  @action
  changeModal(value) {
    return isModalActive = value;
  }

  @action
  changeHeight(value) {
    height = value;
  }

  @action
  changeColor(value) {
    isColorActive = value;
  }

  @action
  changeButtonColor(value) {
    buttonColor = value;
  }
}

// class AppController extends ChangeNotifier {
//   static AppController instance = AppController();

//   double isHeight = 125;

//   bool isModalActive = false;

//   bool isColor = false;

//   String isButtonCollor = '';

//   int nume;

//   changeModal(value) {
//     isModalActive = value;
//     notifyListeners();
//     // print('Value passed: ${value}');
//   }

//   changeHeight(value) {
//     isHeight = value;
//     notifyListeners();
//     // print('Value passed in HEIGHT: ${value}');
//   }

//   changeColor(value) {
//     isColor = value;
//     notifyListeners();
//     // print('Value passed in Color: ${value}');
//   }

//   changeButtonColor(value) {
//     // myColorz[nume].color = 0xff738f66;

//     isButtonCollor = value;

//     notifyListeners();
//     // print('Value passed in Color: ${value}');
//   }
// }
