import 'package:mobx/mobx.dart';
part 'map_controller.g.dart';

class MapController = _MapControllerBase with _$MapController;

abstract class _MapControllerBase with Store {
  @observable
  bool isCardOpen = false;
}