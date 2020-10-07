import 'package:flutter/material.dart';

class PrimaryLabel extends StatelessWidget {
  final Color color;
  final String labelText;

  const PrimaryLabel({
    Key key,
    this.color,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stateColor = color.computeLuminance() > 0.5 ? Colors.grey : color;
    return Container(
      decoration: BoxDecoration(
        color: stateColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 12.0,
        ),
        child: Center(
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: stateColor,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
