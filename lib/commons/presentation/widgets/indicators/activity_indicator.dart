import 'package:flutter/material.dart';

class ActivityIndicator extends StatelessWidget {
  final String semanticsLabel;
  final bool center;
  final Color color;
  final bool tiny;
  const ActivityIndicator({
    Key key,
    @required this.semanticsLabel,
    this.center = true,
    this.color,
    this.tiny = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var indicator = CircularProgressIndicator(
      semanticsLabel: semanticsLabel,
      valueColor:
          AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).accentColor),
    );
    if (!center) return indicator;

    return Center(
      child: !tiny
          ? indicator
          : SizedBox(
              height: 24.0,
              width: 24.0,
              child: indicator,
            ),
    );
  }
}
