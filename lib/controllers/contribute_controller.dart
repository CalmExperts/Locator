import 'package:mobx/mobx.dart';
part 'contribute_controller.g.dart';

class ContributeController = _ContributeControllerBase
    with _$ContributeController;

abstract class _ContributeControllerBase with Store {
  @observable
  int pageIndex = 0;

  @observable
  bool contributeMode = false;

  @action
  changeIndex(int page) {
    if (page == -1) {
      return null;
    }
    pageIndex = page;
  }

  @action
  changeToContributeMode(bool value) {
    contributeMode = value;
  }
}
