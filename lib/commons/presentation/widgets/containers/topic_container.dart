import 'package:app/commons/presentation/widgets/gradients/circle_border_gradient.dart';
import 'package:flutter/material.dart';

import '../animations/widget_animated_opacity.dart';

class TopicContainer extends StatelessWidget {
  final Color primaryColor;
  final IconData iconData;
  final Widget icon;
  final String title;
  final Color titleColor;
  final Widget child;
  final double circleSize;
  final double borderWith;

  TopicContainer({
    Key key,
    this.primaryColor = Colors.blueAccent,
    this.iconData = Icons.insert_emoticon,
    this.title = '',
    this.titleColor = Colors.white,
    this.child,
    this.circleSize = 90.0,
    this.borderWith = 6.0,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: circleSize / 2,
            left: 0,
            bottom: 0,
            right: 0,
            child: _container(context),
          ),
          Positioned(
            top: 0,
            left: 16.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _circle(context),
                _buildTitle(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 16.0,
      ),
      child: WidgetAnimatedOpacity(
        duration: Duration(milliseconds: 500),
        text: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: titleColor,
                fontSize: 15.0,
              ),
        ),
      ),
    );
  }

  Widget _circle(BuildContext context) {
    return CircleBorderGradient(
      size: circleSize,
      borderWith: 8,
      colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColorDark,
      ],
      child: icon != null
          ? Center(child: icon)
          : Icon(
              iconData,
              color: primaryColor,
              size: circleSize / 2,
            ),
    );
  }

  Widget _container(BuildContext context) {
    var paddingTopCalculated = (circleSize / 2) + 8;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
        ),
      ),
      margin: EdgeInsets.zero,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTopCalculated),
        child: child,
      ),
    );
  }
}
