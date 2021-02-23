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
