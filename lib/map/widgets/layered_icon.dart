import 'package:flutter/material.dart';

class LayeredIcon<T> extends StatelessWidget {
  final T icon1, icon2;

  const LayeredIcon({Key key, @required this.icon1, @required this.icon2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = constraints.maxWidth;
        return Container(
          width: size,
          height: size,
          child: Stack(
            children: <Widget>[
              if (T == IconData)
                Align(
                  alignment: Alignment.center,
                  child: Icon(icon1 as IconData),
                ),
              if (T == Widget)
                Align(alignment: Alignment.center, child: icon1 as Widget),
              if (T == IconData)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    icon2 as IconData,
                    size: size / 2.5,
                    color: Colors.grey,
                  ),
                ),
              if (T == Widget)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: icon2 as Widget,
                    height: size / 2.5,
                    width: size / 2 / 5,
                    color: Colors.grey,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
