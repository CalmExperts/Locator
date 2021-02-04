import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final Duration timeOut;
  final String errorMessage;
  final Icon errorIcon;

  const LoadingWidget({
    Key key,
    this.timeOut,
    @required this.errorMessage,
    @required this.errorIcon,
  }) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  bool _loadingTimedOut = false;

  @override
  void initState() {
    super.initState();
    if (widget.timeOut != null) {
      Future.delayed(widget.timeOut).then((_) {
        if (mounted) {
          setState(() {
            _loadingTimedOut = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String text;

    if (_loadingTimedOut) {
      text = widget.errorMessage;
    } else {
      text = 'Loading...';
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (_loadingTimedOut)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<String>(
                  stream: Stream.periodic(Duration(milliseconds: 500), (count) {
                    return '${'.' * (count % 4)}';
                  }),
                  initialData: '',
                  builder: (context, snapshot) {
                    var textStyle = TextStyle(fontSize: 30);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Loading failed',
                          style: textStyle,
                        ),
                        Container(
                          width: 30,
                          child: Text(
                            snapshot.data,
                            style: textStyle,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                text,
                softWrap: true,
                textAlign: TextAlign.center,
              )),
          if (_loadingTimedOut) widget.errorIcon
        ],
      ),
    );
  }
}
