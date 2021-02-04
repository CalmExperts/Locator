import 'dart:async';

import 'package:flutter/material.dart';
import 'package:locator_app/map/widgets/category_button.dart';

class SizeNotifier<T extends Widget> extends StatefulWidget {
  /// The widget that needs to be sized
  final Widget child;

  /// Used in conjunction with height to lay out the child. If both are provided,  onSizeCalculated is not called.
  final double width;

  /// Used in conjunction with width to lay out the child. If both are provided,  onSizeCalculated is not called.
  final double height;

  /// Called after the size is calculated.
  final void Function(Size) onSizeCalculated;

  const SizeNotifier({
    Key key,
    @required this.child,
    this.onSizeCalculated,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _SizeNotifierState createState() => _SizeNotifierState();
}

class _SizeNotifierState<T extends Widget> extends State<SizeNotifier<T>> {
  final key = GlobalKey();
  bool _hasCalculatedSize = false;

  @override
  void initState() {
    super.initState();
    if (!_hasCalculatedSize) {
      calculateSize().then((value) => _notifyListeners(value));
    }
  }

  Future<Size> calculateSize() async {
    final completer = Completer<Size>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox object = key.currentContext.findRenderObject();

      setState(() {
        _hasCalculatedSize = true;
      });
      completer.complete(object.size);
    });
    return completer.future;
  }

  void _notifyListeners(Size size) {
    if (widget.onSizeCalculated != null) {
      widget.onSizeCalculated(size);
    }
    SizeNotification<T>(size: size, widget: widget).dispatch(context);
  }

  @override
  void didUpdateWidget(SizeNotifier<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget is CategoryButton && widget is CategoryButton) {
      // this only works for CategoryButtons
      if (!(oldWidget as CategoryButton)
          .isEqualTo(widget.child as CategoryButton)) {
        _hasCalculatedSize = false;
        calculateSize().then((value) => _notifyListeners(value));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !_hasCalculatedSize,
      child: Container(
        key: key,
        width: widget.width,
        height: widget.height,
        child: widget.child,
      ),
    );
  }
}

class SizeNotification<T> extends Notification {
  final Size size;
  final Widget widget;

  SizeNotification({
    @required this.size,
    @required this.widget,
  });
}

/// A widget that listens for [SizeNotification]s bubbling up the tree.
///
/// Notifications will trigger the [onNotification] callback only if their
/// [runtimeType] is a subtype of `T`.
///
/// To dispatch notifications, use the [Notification.dispatch] method
class SizeNotificationListener<T extends Widget>
    extends NotificationListener<SizeNotification<T>> {
  const SizeNotificationListener({
    @required Widget child,
    @required NotificationListenerCallback<SizeNotification<T>> onNotification,
  }) : super(child: child, onNotification: onNotification);
}
