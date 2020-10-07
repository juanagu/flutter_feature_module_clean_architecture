import 'package:flutter/material.dart';

class CircleBorderGradient extends StatelessWidget {
  final double size;
  final double borderWith;
  final Widget child;
  final List<Color> colors;

  const CircleBorderGradient({
    Key key,
    @required this.size,
    @required this.borderWith,
    @required this.child,
    @required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var internalCircleSize = size - borderWith * 2;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: const Color(0x26000000),
                    offset: Offset(0, 4),
                    blurRadius: 20,
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.circular(size),
              gradient: LinearGradient(
                stops: [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors,
              ),
            ),
          ),
        ),
        Positioned(
          top: borderWith,
          left: borderWith,
          right: borderWith,
          bottom: borderWith,
          child: Container(
            height: internalCircleSize,
            width: internalCircleSize,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(internalCircleSize),
            ),
            child: child,
          ),
        )
      ],
    );
  }
}
