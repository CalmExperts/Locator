import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/auth/auth.dart';
import 'package:locator/auth/models/user.dart';
import 'package:locator/map/models/drop.dart';
import 'package:locator/marks/models/mark.dart';
import 'package:locator/marks/services/like_service.dart';
import 'package:locator/resources/colors.dart';
import 'package:provider/provider.dart';

class Likes extends StatelessWidget {
  final Drop drop;
  final User user;

  const Likes({Key key, @required this.drop, @required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).currentUser;
    return StreamBuilder<Like>(
      stream: GetIt.I.get<MarkService>().isMarked(drop.id, user.id),
      builder: (context, AsyncSnapshot<Like> snapshot) {
        if (snapshot.hasError) return Container();
        Like mark = snapshot.data;
        return Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.sentiment_satisfied,
                color: mark != null && mark.isLike ? darkAccent : primaryText,
              ),
              onPressed: () {
                if (mark == null || !mark.isLike) like();
                if (mark != null && mark.isLike) removeMark();
              },
            ),
            StreamBuilder<int>(
              stream: GetIt.I.get<MarkService>().howMany(drop.id),
              builder: (context, AsyncSnapshot<int> howMany) {
                if (snapshot.hasError) return Container();
                return Container(
                  width: 32,
                  child: Text(
                    howMany.data?.toString() ?? '',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.sentiment_dissatisfied,
                color: mark != null && mark.type == 'dislike'
                    ? error
                    : primaryText,
              ),
              onPressed: dislike,
            ),
          ],
        );
      },
    );
  }

  void like() => GetIt.I.get<MarkService>().mark(drop.id, user.id, 'like');

  void removeMark() => GetIt.I.get<MarkService>().removeMark(drop.id, user.id);

  void dislike() =>
      GetIt.I.get<MarkService>().mark(drop.id, user.id, 'dislike');
}
