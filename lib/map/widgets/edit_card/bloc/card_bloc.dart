library card_bloc;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:locator_app/general/bloc_globals.dart';
import 'package:locator_app/map/bloc/map_bloc.dart';
import 'package:locator_app/map/models/category.dart';
import 'package:locator_app/map/models/coordinates.dart';
import 'package:locator_app/map/models/drop.dart';
import 'package:locator_app/map/services/category_service.dart';
import 'package:locator_app/map/services/drop_service.dart';
import 'package:locator_app/map/widgets/edit_card/subcategory_scroll_view.dart';
import 'package:locator_app/map/widgets/map_background.dart';
import 'package:locator_app/resources/enums.dart';
import 'package:rxdart/rxdart.dart';

part 'card_event.dart';

part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final DropService dropService;
  final CardState _initialState;
  StreamSubscription _categoryStreamSubscription;

  CardBloc({
    @required this.dropService,
    CardState initialState,
    @required CategoryService categoryService,
  })  : _initialState = initialState,
        super(null) {
    _categoryStreamSubscription =
        CombineLatestStream.combine3<Category, Category, Subcategory, List>(
                categoryService.activeTopCategoryStream,
                categoryService.activeCategoryStream,
                categoryService.activeSubcategoryStream,
                (activeTopCategory, activeCategory, activeSubcategory) =>
                    [activeTopCategory, activeCategory, activeSubcategory])
            .where((info) => info
                .every((element) => element != null)) // skipping null entries
            .listen(
      (value) {
        final mapState = GetIt.I.get<MapBloc>().state;
        final cardIsOpen = mapState.isCardOpen;
        final cardContent =
            MapBackground.mapBackgroundKey.currentState.cardContent;
        if (cardIsOpen && cardContent is! SubcategoryScrollView) {
          add(
            UpdateDrop(
              topCategory: value[0],
              category: value[1],
              subcategory: value[2],
            ),
          );
        }
      },
    );
  }

  @override
  CardState get initialState => _initialState ?? CardState.initial();

  static CardBloc of(BuildContext context) =>
      BlocProvider.of<CardBloc>(context);

  @override
  Stream<CardState> mapEventToState(event) async* {
    if (event is SelectCategoryEvent) {
      yield state.copyWith(dropCategory: event.category);
    } else if (event is SaveDrop) {
      if (state.drop.documentReference == null) {
        debugPrint('Creating drop.');

        final dropReference = await dropService.create(state.drop);
        debugPrint('Created drop. ID: ${dropReference.id}');
      } else {
        dropService.update(state.drop);
        debugPrint('Updated drop. ID: ${state.drop.id}');
      }
    } else if (event is UpdateDrop) {
      yield state.copyWith(
        drop: state.drop.copyWith(
          topCategory: event.topCategory,
          category: event.category,
          subcategory: event.subcategory,
          coordinates: event.coordinates,
          location: event.location,
          condition: event.condition,
          addedBy: event.addedBy,
          lastEdited: event.lastEdited,
          verified: event.verified,
          likes: event.likes,
          open: event.availabilityDescription,
          isDraft: event.isDraft,
          tags: event.tags,
        ),
      );
      add(SaveDrop());
    } else if (event is SetDrop) {
      yield state.copyWith(drop: event.drop);
    } else if (event is UpdateEditDropCardPage) {
      yield state.copyWith(activeEditDropCardPage: event.page);
    } else if (event is Reset) {
      yield CardState.initial();
    }
//    _runAssertions(); //
  }

  void reset() => add(Reset());

  @override
  void onTransition(Transition<CardEvent, CardState> transition) {
    super.onTransition(transition);
  }

  @override
  Future<void> close() {
    _categoryStreamSubscription.cancel();
    return super.close();
  }

  _runAssertions() {
    final mapState = GetIt.I.get<MapBloc>().state;
    final drop = state.drop;
    assert(mapState.activeTopCategory == drop.topCategory);
    assert(mapState.activeCategory == drop.category);
//    assert(mapState.activeSubcategory == drop.subcategory);
  }

  void addAll(List<CardEvent> events) => events.forEach(add);
}
