library create_card;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show AsyncCallback;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/general/widgets/primary_button.dart';
import 'package:locator/locale/locales.dart';
import 'package:locator/map/bloc/map_bloc.dart';
import 'package:locator/map/models/category.dart';
import 'package:locator/map/models/drop.dart';
import 'package:locator/map/models/tag.dart';
import 'package:locator/map/widgets/category_bar.dart';
import 'package:locator/map/widgets/drop_card.dart';
import 'package:locator/map/widgets/edit_card/bloc/card_bloc.dart';
import 'package:locator/map/widgets/edit_card/subcategory_scroll_view.dart';
import 'package:locator/map/widgets/edit_card/summary_card.dart';
import 'package:locator/map/widgets/edit_card/tags_card.dart';
import 'package:locator/map/widgets/flexible_container.dart';
import 'package:locator/map/widgets/star.dart';
import 'package:locator/resources/dimensions.dart';
import 'package:locator/resources/enums.dart';
import 'package:locator/utils/exceptions.dart';
import 'package:locator/utils/extensions.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sprung/sprung.dart';

part 'category_card.dart';
part 'comment_card.dart';
part 'condition_card.dart';
part 'location_card.dart';

class CreateDropCard extends StatefulWidget {
  final AsyncCallback close;
  final LatLng position;
  final Drop drop;
  final EditDropCardPage initialPage;

  const CreateDropCard({
    Key key,
    @required this.close,
    this.position,
    this.drop,
    this.initialPage = EditDropCardPage.category,
  }) : super(key: key);

  @override
  _CreateDropCardState createState() => _CreateDropCardState();
}

class _CreateDropCardState extends State<CreateDropCard> {
  TextEditingController locationController;
  TextEditingController openController;

  PageController pageViewController;

  double dropCardHeight;

  @override
  void initState() {
    final cardBloc = BlocProvider.of<CardBloc>(context);
    cardBloc.add(UpdateEditDropCardPage(widget.initialPage));
    pageViewController = PageController(initialPage: widget.initialPage.index);
    final drop = cardBloc.state.drop;
    locationController = TextEditingController(text: drop.location);
    openController = TextEditingController(text: drop.open);
    debugPrint('Edit card is being displayed');
    super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    openController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: DropCard(
        child: BlocBuilder<CardBloc, CardState>(
          builder: (BuildContext context, state) {
            return Padding(
              padding: dropCardInternalPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlexibleScrollableContainer(
                    scrollDirection: Axis.vertical,
                    maxHeight: MediaQuery.of(context).size.height * .5,
                    builder: (context, constraints) {
                      return SizedBox(
                        height:
                            state.isAtLastPage ? constraints.maxHeight : 152,
                        child: PageView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          controller: pageViewController,
                          itemCount: EditDropCardPage.values.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildChild(EditDropCardPage.values[index]),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: buildCardFooter(state),
                  )
                ],
              ),
            );
          },
        ),
//        onClose: widget.onClosed,
      ),
    );
  }

  Row buildCardFooter(CardState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        PrimaryButton(
          child: Text('Prev'),
          onPressed: state.activeEditDropCardPage.index == 0 ? null : back,
        ),
        Expanded(
          child: LinearPercentIndicator(
            lineHeight: 3,
            percent: progressPercentage(state),
            progressColor: Theme.of(context).primaryColor,
            animateFromLastPercent: true,
            animation: true,
            animationDuration: 500,
          ),
        ),
        PrimaryButton(
          child: Text(!state.isAtLastPage ? 'Next' : 'Save'),
          onPressed: enableNext(state)
              ? () {
                  onNext(state.activeEditDropCardPage);
                  proceed();
                }
              : null,
        ),
      ],
    );
  }

  bool enableNext(CardState state) {
    final currentPage = state.activeEditDropCardPage;
    final drop = state.drop;
    switch (currentPage) {
      case EditDropCardPage.category:
        return drop.category != null;
      case EditDropCardPage.location:
        return locationController.text.isNotEmpty;
        break;
      case EditDropCardPage.condition:
        return drop.condition != null;
        break;
      case EditDropCardPage.comment:
        return true;
        break;
      case EditDropCardPage.summary:
      case EditDropCardPage.tags:
        return true;
        break;
      default:
        throw InvalidDataException('$currentPage is not a valid page');
    }
  }

  double progressPercentage(CardState state) =>
      (state.activeEditDropCardPage.index + 1) / EditDropCardPage.values.length;

  EditDropCardPage get currentPage => cardBloc.state.activeEditDropCardPage;

  Widget buildChild(EditDropCardPage currentPage) {
    switch (currentPage) {
      case EditDropCardPage.category:
        return CategoryCardView(
          onCategoryChosen: (Category category) => cardBloc
            ..add(SelectCategoryEvent(category))
            ..add(UpdateDrop(category: category)),
        );
      case EditDropCardPage.location:
        return LocationCardView(
          dropCategory: cardBloc.state.dropCategory,
          locationController: locationController,
        );
      case EditDropCardPage.condition:
        return ConditionCardView(
          dropCondition: cardBloc.state.drop.condition,
          onChange: (double condition) {
            cardBloc.add(UpdateDrop(condition: condition));
          },
        );
      case EditDropCardPage.comment:
        {
          return CommentCardView(
            openController: openController,
          );
        }
      case EditDropCardPage.tags:
        {
          return TagsCard(
            tags: cardBloc.state.drop.lowestLevelCategory.tags?.map(
                (key, value) => MapEntry(key, Tag(name: key, options: value))),
          );
        }
      case EditDropCardPage.summary:
        return SummaryCardView(
          drop: cardBloc.state.drop,
        );
      default:
        throw InvalidDataException('$currentPage is not a valid card');
    }
  }

  CardBloc get cardBloc => context.bloc<CardBloc>();

  void updateState(EditDropCardPage page) {
    cardBloc.add(UpdateEditDropCardPage(page));
    pageViewController.animateToPage(page.index,
        duration: animationDuration, curve: Sprung());
  }

  void proceed() {
    final int nextIndex = currentPage.index + 1;
    if (nextIndex.isWithin(0, EditDropCardPage.values.length - 1)) {
      EditDropCardPage nextPage = EditDropCardPage.values[nextIndex];
      updateState(nextPage);
    }
    if (cardBloc.state.isAtLastPage) {
      widget.close();
    }
  }

  Future<void> onNext(EditDropCardPage page) async {
    void listener() {
      setState(() {});
    }

    switch (currentPage) {
      case EditDropCardPage.category:
        locationController.addListener(listener);
        break;
      case EditDropCardPage.location:
        cardBloc.add(UpdateDrop(location: locationController.text));
        locationController.removeListener(listener);
        openController.addListener(listener);
        break;
      case EditDropCardPage.comment:
        openController.removeListener(listener);
        cardBloc.add(
          UpdateDrop(
            lastEdited: Timestamp.now(),
            availabilityDescription: openController.text,
            verified: false,
            likes: 0,
          ),
        );
        break;
      case EditDropCardPage.summary:
        await widget.close();
        cardBloc.addAll([UpdateDrop(isDraft: false), Reset()]);
        break;
      default:
        return;
    }
  }

  void back() {
    final int previousIndex = EditDropCardPage.values.indexOf(currentPage) - 1;
    if (previousIndex.isWithin(0, EditDropCardPage.values.length - 1)) {
      EditDropCardPage previousPage = EditDropCardPage.values[previousIndex];
      updateState(previousPage);
    } else {
      throw Exception('$previousIndex is not a valid page index.');
    }
  }
}
