import 'package:flutter/material.dart';

class WidgetAnimatedOpacity extends StatefulWidget {
  final Widget text;
  final Duration duration;

  WidgetAnimatedOpacity({
    Key key,
    this.text,
    this.duration,
  }) : super(key: key);

  @override
  _WidgetAnimatedOpacityState createState() => _WidgetAnimatedOpacityState();
}

class _WidgetAnimatedOpacityState extends State<WidgetAnimatedOpacity> {
  double opacityValue = 0;

  @override
  void initState() {
    super.initState();
    _animate();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      opacity: opacityValue,
      child: Material(
        color: Colors.transparent,
        child: widget.text,
      ),
    );
  }

  Future _animate() async {
    await Future.delayed(
        Duration(milliseconds: 0),
        () => {
              setState(() {
                opacityValue = 1.0;
              })
            });
  }
}
