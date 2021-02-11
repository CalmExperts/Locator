import 'package:flutter/material.dart';
import 'package:locator/auth/auth.dart';
import 'package:locator/map/models/drop.dart';
import 'package:locator/map/services/distance_service.dart';
import 'package:locator/marks/widgets/likes.dart';
import 'package:locator/resources/colors.dart';
import 'package:locator/resources/dimensions.dart';
import 'package:locator/utils/extensions.dart';
import 'package:provider/provider.dart';

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
  final Color color;

  const BottomSheetHandle({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        margin: EdgeInsets.only(top: 15),
        height: 5,
        width: constraints.maxWidth / 7,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
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
        child: Text(
          drop.category.name.substring(0, 1) ?? '?',
          style: Theme.of(context)
              .primaryTextTheme
              .headline6
              .copyWith(color: primaryText),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).disabledColor),
        color: Theme.of(context).buttonColor,
        shape: BoxShape.circle,
      ),
      height: MediaQuery.of(context).size.width * .25,
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
          Container(
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
                                  .headline6
                                  .copyWith(
                                    color: primaryText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          Text(
                            distanceService.display(),
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(color: primaryText, fontSize: 16),
                          ),
                          if (widget.drop != null)
                            Text(
                              widget.drop.location,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .copyWith(color: primaryText, fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    Container(width: MediaQuery.of(context).size.width * .1)
                  ],
                ),
                SingleChildScrollView(),
                SingleChildScrollView(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: widget.onClose,
                ),
                // Likes(
                //   drop: widget.drop,
                //   user: Provider.of<Auth>(context).currentUser,
                // ),
              ],
            ),
          )
        ],
      ),
//      onClose: widget.onClose,
    );
  }
}
