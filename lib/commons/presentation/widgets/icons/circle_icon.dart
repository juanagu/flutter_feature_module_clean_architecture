import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;
  final double iconSize;
  final double circleSize;
  final Color iconColor;

  const CircleIcon({
    Key key,
    @required this.backgroundColor,
    @required this.iconData,
    this.iconSize = 30.0,
    this.circleSize = 50.0,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = iconColor ?? backgroundColor.computeLuminance() > 0.5
        ? Colors.grey
        : Colors.white;
    var borderColor = backgroundColor.computeLuminance() > 0.5
        ? Color(0xffe1dede)
        : backgroundColor;
    return Container(
      height: circleSize,
      width: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
        ),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
              color: Color(0x33000000),
              offset: Offset(6, 4),
              blurRadius: 10,
              spreadRadius: 0)
        ],
      ),
      child: Icon(
        iconData,
        color: color,
        size: iconSize,
      ),
    );
  }
}
