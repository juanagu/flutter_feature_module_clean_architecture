import 'package:app/commons/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final String title;
  final String message;
  final bool withCard;
  final Function onRetry;
  final String retryLabel;

  const ErrorView({
    Key key,
    this.iconData = Icons.error,
    this.iconSize = 80.0,
    this.title = '',
    this.message = '',
    this.withCard = false,
    this.onRetry,
    this.retryLabel = 'Retry',
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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIcon(context),
          _buildTitle(context),
          _buildMessage(context),
          _buildRetryButton(context),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    if (message.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container();
  }

  Widget _buildTitle(BuildContext context) {
    if (title.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container();
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(
      iconData,
      size: iconSize,
      color: Theme.of(context).errorColor,
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    if (retryLabel.isNotEmpty && onRetry != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: PrimaryButton(
          onPressed: onRetry,
          titleText: retryLabel,
        ),
      );
    }

    return Container();
  }
}
