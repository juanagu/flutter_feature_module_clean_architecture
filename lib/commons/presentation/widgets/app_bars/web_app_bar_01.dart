import 'package:flutter/material.dart';

class WebAppBar01 extends StatelessWidget {
  final Widget leading;
  final double horizontalPadding;
  final String title;
  final Widget action;
  final double height;

  const WebAppBar01({
    Key key,
    @required this.title,
    this.leading,
    this.horizontalPadding,
    this.action,
    this.height = 80.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Theme.of(context).appBarTheme.color,
      child: Padding(
        padding: _calculatePadding(context),
        child: Row(
          children: [
            leading ?? SizedBox.shrink(),
            Expanded(
                child: Text(
              title,
              style: Theme.of(context).appBarTheme.textTheme.headline6,
            )),
            action ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  EdgeInsets _calculatePadding(BuildContext context) {
    if (horizontalPadding != null) {
      return EdgeInsets.symmetric(horizontal: horizontalPadding);
    }

    var width = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(horizontal: width * 0.1);
  }
}
