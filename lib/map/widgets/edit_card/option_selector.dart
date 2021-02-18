import 'package:flutter/material.dart';
import 'package:locator/general/widgets/platform_builder.dart';
import 'package:locator/resources/style/colors.dart';
import 'package:locator/resources/dimensions.dart';

enum OptionSelectorState { open, closed }

class OptionSelector<T> extends StatelessWidget {
  final T value;
  final List<T> options;
  final Widget leading;
  final IndexedWidgetBuilder builder;
  final ValueChanged<T> onPressed;

  OptionSelector({
    Key key,
    @required this.value,
    @required this.options,
    @required this.leading,
    @required this.builder,
    @required this.onPressed,
  })  : assert(value is T),
        assert(() {
          if (value != null) {
            return options.contains(value);
          }
          return true;
        }()),
        assert(options.toSet().length == options.length),
        super(key: key);

  OptionSelectorState get state =>
      value == null ? OptionSelectorState.open : OptionSelectorState.closed;

  @override
  Widget build(BuildContext context) {
    final Border _selectedBorder =
        Border.all(color: Theme.of(context).primaryColor, width: 3);
    return Container(
      decoration: rectangleDecoration(context: context)
          .copyWith(borderRadius: BorderRadius.circular(15)),
      height: 100,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: leading,
          ),
          if (value == null)
            for (int index = 0; index < options.length; index++)
              PlatformBuilder(
                iOS: (context) => GestureDetector(
                  child: builder(context, index),
                  onTap: () => onPressed(options[index]),
                ),
                macOS: (context) => GestureDetector(
                  child: builder(context, index),
                  onTap: () => onPressed(options[index]),
                ),
                fallback: (context) => InkWell(
                  child: builder(context, index),
                  onTap: () => onPressed(options[index]),
                ),
              )
          else
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    border: _selectedBorder,
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.zero,
                child: PlatformBuilder(
                  iOS: (context) => GestureDetector(
                    child: builder(context, options.indexOf(value)),
                    onTap: () => onPressed(null),
                  ),
                  macOS: (context) => GestureDetector(
                    child: builder(context, options.indexOf(value)),
                    onTap: () => onPressed(null),
                  ),
                  fallback: (context) => InkWell(
                    child: builder(context, options.indexOf(value)),
                    onTap: () => onPressed(null),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
