import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinearIndicator extends StatelessWidget {
  const LinearIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      alignment: MainAxisAlignment.center,
      width: MediaQuery.of(context).size.width * 0.5,
      animation: true,
      lineHeight: 12.0,
      percent: 1.0,
      animationDuration: 3000,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
    );
  }
}
