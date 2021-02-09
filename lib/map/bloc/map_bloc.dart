import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator/general/bloc_globals.dart';
import 'package:locator/map/models/category.dart';
import 'package:locator/map/services/category_service.dart';
import 'package:locator/map/widgets/map_background.dart';
import 'package:rxdart/rxdart.dart';

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final CategoryService categoryService;

  @override
  MapState get initialState => MapInitial();
  StreamSubscription _mapStreamSubscription;

  static MapBloc of(BuildContext context) => BlocProvider.of<MapBloc>(context);

  MapBloc({@required this.categoryService}) : super(MapInitial()) {
    _mapStreamSubscription = CombineLatestStream.combine5<List<Category>,
        List<Category>, Category, Category, Subcategory, MapState>(
      categoryService.topCategoryStream,
      categoryService.categoryStream,
      categoryService.activeTopCategoryStream,
      categoryService.activeCategoryStream,
      categoryService.activeSubcategoryStream,
      (topCategories, categories, activeTop, activeCategory, activeSub) {
        return state
            .copyWith(
              topCategories: topCategories,
              categories: categories,
              activeTopCategory: activeTop,
              activeCategory: activeCategory,
              activeSubcategory: activeSub,
            )
            .setAsNull(
              activeTopCategory: activeTop == null,
              activeCategory: activeCategory == null,
              activeSubcategory: activeSub == null,
            );
      },
    ).listen((value) {
      add(SetState(value));
    });
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is SetActiveTopCategory) {
      categoryService.setActiveTopCategory(event.category);
    } else if (event is SetActiveCategory) {
      categoryService.setActiveCategory(event.category);
    } else if (event is SetActiveSubcategory) {
      categoryService.setActiveSubcategory(event.category);
    } else if (event is SetState) {
      yield event.state;
    } else if (event is ChangeCardOpenState) {
      yield state.copyWith(isCardOpen: event.isCardOpen);
    } else if (event is ShowCard) {
      final PersistentBottomSheetController controller =
          MapBackground.showBottomSheet(content: event.content);
      event.controllerCompleter.complete(controller);
      add(ChangeCardOpenState(isCardOpen: true));
    } else if (event is CloseCard) {
      MapBackground.persistentBottomSheetController.close();
    }
  }

  void setActiveCategory(Category category) {
    add(SetActiveCategory(category));
  }

  @override
  void onTransition(Transition<MapEvent, MapState> transition) {
    super.onTransition(transition);
  }

  @override
  Future<void> close() {
    _mapStreamSubscription.cancel();
    return super.close();
  }
}
