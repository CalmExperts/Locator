import 'package:flutter/material.dart';
import 'package:locator/main.dart';
import 'package:locator/map/widgets/tags/mark_card.dart';
import 'package:locator/map/widgets/tags/small_mark_card.dart';
import 'package:locator/map/widgets/tags/tag_card.dart';
import 'package:locator/marks/widgets/likes.dart';
import 'package:locator/options/routes/options_page.dart';

import '../../resources/dimensions.dart';
import '../../utils/extensions.dart';
import '../models/drop.dart';
import '../services/distance_service.dart';

class DropCard extends StatefulWidget {
  final Widget child;

  const DropCard({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _DropCardState createState() => _DropCardState();
}

class _DropCardState extends State<DropCard> {
  static const EdgeInsets _dropCardPadding =
      EdgeInsets.symmetric(horizontal: 8, vertical: 10);

  @override
  Widget build(BuildContext context) {
    int spacerFlex = 3;
    return Card(
      color: Theme.of(context).primaryColorDark,
      margin: _dropCardPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Spacer(flex: spacerFlex),
              Expanded(child: BottomSheetHandle()),
              Spacer(
                flex: spacerFlex,
              ),
            ],
          ),
          widget.child,
        ],
      ),
    );
  }
}

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        height: 5,
        width: constraints.maxWidth / 7,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    });
  }
}

class CategoryIcon extends StatelessWidget {
  final Drop drop;

  const CategoryIcon(this.drop);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(
          Icons.store_outlined,
          size: 56,
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        shape: BoxShape.circle,
      ),
      height: MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width * .25,
    );
  }
}

class ViewDropCard extends StatefulWidget {
  final Drop drop;
  final Function onClose;

  const ViewDropCard({Key key, @required this.drop, this.onClose})
      : super(key: key);

  @override
  _ViewDropCardState createState() => _ViewDropCardState();
}

class _ViewDropCardState extends State<ViewDropCard> {
  DistanceService distanceService;

  @override
  void initState() {
    super.initState();
    distanceService = DistanceService();
  }

  @override
  Widget build(BuildContext context) {
    return DropCard(
      child: Stack(
        children: <Widget>[
          //TODA TELA
          Container(
            decoration:
                BoxDecoration(color: Theme.of(context).primaryColorDark),
            padding: dropCardInternalPadding,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CategoryIcon(widget.drop),
                    Container(width: padding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (widget.drop != null)
                            Text(
                              widget.drop.category.name.capitalize(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  /*.title*/
                                  .headline6,
                            ),
                          Text(
                            distanceService.display(),
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                          if (widget.drop != null)
                            Text(
                              widget.drop.location,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    Container(width: MediaQuery.of(context).size.width * .2)
                  ],
                ),
                SingleChildScrollView(),
                SingleChildScrollView(),
                Container(
                  height: 100,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      MarkCard(
                        text: 'OUTDOOR',
                        // icon: Icons.sensor_door,
                        onPressed: () {
                          print('OUTDOOR!');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OptionsPage(),
                            ),
                          );
                        },
                      ),
                      MarkCard(
                        text: 'INDOOR',
                        // icon: Icons.sensor_door,
                        onPressed: () {
                          print('INDOOR!');
                        },
                      ),
                      MarkCard(
                        text: 'INDOOR',
                        // icon: Icons.sensor_door_outlined,
                        onPressed: () {
                          print('INDOOR!');
                        },
                      ),
                      MarkCard(
                        text: 'OUTDOOR',
                        // icon: Icons.sensor_door_outlined,
                        onPressed: () {
                          print('OUTDOOR!');
                        },
                      ),
                      MarkCard(
                        text: 'OUTDOOR',
                        // icon: Icons.sensor_door_outlined,
                        onPressed: () {
                          print('OUTDOOR!');
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 65,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SmallMarkCard(
                        text: 'EDIT',
                        icon: Icons.edit_outlined,
                        onPressed: () {
                          print('EDIT!');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OptionsPage(),
                            ),
                          );
                        },
                      ),
                      SmallMarkCard(
                        text: 'MAP',
                        icon: Icons.map,
                        onPressed: () {
                          print('MAP!');
                        },
                      ),
                      SmallMarkCard(
                        text: 'TEXT',
                        icon: Icons.text_format_sharp,
                        onPressed: () {
                          print('TEXT!');
                        },
                      ),
                      SmallMarkCard(
                        text: 'MESSAGE',
                        icon: Icons.message_outlined,
                        onPressed: () {
                          print('MESSAGE!');
                        },
                      ),
                      SmallMarkCard(
                        text: 'CLOCK',
                        icon: Icons.access_time_rounded,
                        onPressed: () {
                          print('CLOCK!');
                        },
                      ),
                      SmallMarkCard(
                        text: 'STAR',
                        icon: Icons.star_border,
                        onPressed: () {
                          print('STAR!');
                        },
                      ),
                      SmallMarkCard(
                        text: 'PIN',
                        icon: Icons.pin_drop_outlined,
                        onPressed: () {
                          print('PIN!');
                        },
                      ),
                      SmallMarkCard(
                        text: 'REWARD',
                        icon: Icons.card_giftcard_outlined,
                        onPressed: () {
                          print('REWARD!');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 12.0),
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 65,
                  child: Column(
                    children: [
                      FlatButton(
                        height: 28,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                            color: Theme.of(context).indicatorColor,
                            width: 2,
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'OPEN',
                              style: TextStyle(
                                color: Theme.of(context).indicatorColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        // onPressed: () {
                        //   print('OPEN NOW');
                        // },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('3'),
                          Container(width: 8),
                          Icon(Icons.sentiment_satisfied)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

//      onClose: widget.onClose,
    );
  }
}
