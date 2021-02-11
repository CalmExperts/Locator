import 'package:flutter/material.dart';
import 'package:locator/auth/auth.dart';
import 'package:locator/resources/constants.dart';
import 'package:provider/provider.dart';

class UserAvatar extends StatelessWidget {
  final double radius;

  const UserAvatar({Key key, this.radius = navigationRadius * 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<Auth>(context).currentUser == null
        ? Container()
        : Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                    Provider.of<Auth>(context).currentUser.picUrl,
                  ),
                  fit: BoxFit.fill),
            ),
          );
  }
}
