import 'package:flutter/material.dart';

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
        margin: EdgeInsets.only(top: 15),
        height: 5,
        width: constraints.maxWidth / 7,
        decoration: BoxDecoration(
          // color: Theme.of(context).accentColor,
          color: Colors.green,
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
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).accentColor),
        color: Theme.of(context).primaryColorLight,
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
            right: MediaQuery.of(context).size.width * 0.04,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: Icon(Icons.clear),
                  ),
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
