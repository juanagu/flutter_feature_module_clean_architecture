import 'package:app/apps/custom_app/custom_app_themes.dart';
import 'package:flutter/material.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class CustomTooltip extends StatelessWidget {
  final String tooltipText;
  final Widget child;
  final Function onPressed;

  const CustomTooltip({
    Key key,
    @required this.tooltipText,
    @required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleTooltip(
      tooltipTap: onPressed,
      ballonPadding: EdgeInsets.zero,
      minimumOutSidePadding: 0,
      customShadows: [],
      maxHeight: 38.0,
      arrowLength: 12.0,
      arrowTipDistance: 0,
      arrowBaseWidth: 8.0,
      backgroundColor: CustomAppThemes.properties().backgroundTooltipColor,
      borderColor: Colors.transparent,
      show: true,
      tooltipDirection: TooltipDirection.right,
      child: child,
      content: Text(
        tooltipText,
        style: Theme.of(context).textTheme.caption.copyWith(
              decoration: TextDecoration.underline,
              color: Theme.of(context).primaryColorDark,
            ),
        maxLines: 1,
      ),
    );
  }
}
