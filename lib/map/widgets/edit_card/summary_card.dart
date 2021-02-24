import 'package:flutter/material.dart';
import 'package:locator/map/models/drop.dart';
import 'package:locator/map/widgets/category_icon.dart';
import 'package:locator/utils/extensions.dart';

class SummaryCardView extends StatelessWidget {
  final Drop drop;

  const SummaryCardView({Key key, @required this.drop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Did we get it right?'.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle1,
//            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SummaryCategoryTile(
              drop: drop,
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.edit_location),
              ),
              title: Text('Location'),
              subtitle: Text(drop?.location ?? 'Location not provided'),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (final tag in drop.tags.entries)
                      SummaryTagTile(tag: tag)
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class SummaryTagTile extends StatelessWidget {
  const SummaryTagTile({
    Key key,
    @required this.tag,
  }) : super(key: key);

  final MapEntry tag;
  static const double aspectRatio = 1.5;
  static const double borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: borderWidth,
          ),
        ),
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: ListTile(
            title: Text(
              "${(tag.key as String).capitalize()}: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text((tag.value as String).capitalize(),
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ),
      ),
    );
  }
}

class SummaryCategoryTile extends StatelessWidget {
  final Drop drop;

  const SummaryCategoryTile({Key key, @required this.drop})
      : assert(drop != null && drop != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(color: Theme.of(context).primaryColor),
            shape: BoxShape.circle),
        child: CategoryIcon(
          category: drop.category,
          size: 48,
        ),
      ),
      title: Text(drop.category?.name ?? 'Category not provided'),
      subtitle: Text.rich(
        TextSpan(
          text: 'Location: ',
          children: [
            TextSpan(
                text: '${drop.location ?? 'No location provided'}',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}