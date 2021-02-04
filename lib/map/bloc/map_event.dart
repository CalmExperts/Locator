part of 'map_bloc.dart';

abstract class MapEvent extends Event {
  MapEvent();
}

class SetActiveTopCategory extends MapEvent {
  final Category category;

  SetActiveTopCategory(this.category);
}

class SetActiveCategory extends MapEvent {
  final Category category;

  SetActiveCategory(this.category);
}

class SetActiveSubcategory extends MapEvent {
  final Subcategory category;

  SetActiveSubcategory(this.category);
}

class SetState extends MapEvent {
  final MapState state;

  SetState(this.state);
}

class ChangeCardOpenState extends MapEvent {
  final bool isCardOpen;

  ChangeCardOpenState({@required this.isCardOpen});
}

class ShowCard extends MapEvent {
  final Widget content;
  final Completer<PersistentBottomSheetController> controllerCompleter =
      Completer();

  ShowCard({@required this.content});
}

class CloseCard extends MapEvent {}
