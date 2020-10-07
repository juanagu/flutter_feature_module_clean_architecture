import 'package:app/commons/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final String message;
  final bool withCard;
  final Function onRetry;
  final String retryLabel;

  const InfoView({
    Key key,
    this.iconData,
    this.iconSize = 80.0,
    this.iconColor,
    this.message,
    this.withCard = false,
    this.onRetry,
    this.retryLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var content = _buildContent(context);
    if (!withCard) {
      return content;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: content,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    var infoColor = iconColor ?? Theme.of(context).iconTheme.color;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: iconSize,
            color: infoColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .overline
                  .copyWith(fontSize: 16.0, color: infoColor),
              textAlign: TextAlign.center,
            ),
          ),
          _buildRetryButton(context),
        ],
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    if (retryLabel.isNotEmpty && onRetry != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: PrimaryButton(
          onPressed: onRetry,
          titleText: retryLabel,
          buttonColor: Theme.of(context).primaryColor,
        ),
      );
    }

    return SizedBox(
      height: 0,
    );
  }
}
