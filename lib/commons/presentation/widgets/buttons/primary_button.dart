import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String titleText;
  final Function onPressed;
  final Color buttonColor;
  final FocusNode focusNode;
  final bool toUpperCase;
  final bool isBusy;
  final bool outline;
  final bool expanded;
  final bool tiny;
  const PrimaryButton({
    Key key,
    @required this.titleText,
    this.onPressed,
    this.buttonColor,
    this.focusNode,
    this.toUpperCase = false,
    this.isBusy = false,
    this.outline = false,
    this.expanded = false,
    this.tiny = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var button = _buildButton(context);
    if (!expanded) return button;

    return SizedBox(width: double.infinity, child: button);
  }

  MaterialButton _buildButton(BuildContext context) {
    var accentColor = buttonColor ?? Theme.of(context).accentColor;
    var textColor = _getTextColor(accentColor);

    var borderRadius = BorderRadius.circular(6.0);

    if (outline) {
      return FlatButton(
        onPressed: isBusy ? null : onPressed,
        focusNode: focusNode,
        child: _buildContent(context, textColor),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(
            color: textColor,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
      );
    }

    return RaisedButton(
      elevation: 5,
      focusElevation: 10,
      color: accentColor,
      onPressed: isBusy ? null : onPressed,
      focusNode: focusNode,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: _buildContent(context, textColor),
    );
  }

  Color _getTextColor(Color accentColor) {
    var textColor;

    if (outline) {
      textColor = accentColor;
    } else {
      textColor =
          accentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    }
    return textColor;
  }

  Widget _buildContent(
    BuildContext context,
    Color textColor,
  ) {
    return Padding(
      padding: _getContentPadding(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isBusy
              ? Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 18.0,
                    width: 18.0,
                  ),
                )
              : SizedBox.shrink(),
          Text(
            toUpperCase ? titleText.toUpperCase() : titleText,
            style: Theme.of(context).textTheme.button.copyWith(
                  color: textColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  EdgeInsets _getContentPadding() {
    if (tiny) return EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0);
    return EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0);
  }
}
