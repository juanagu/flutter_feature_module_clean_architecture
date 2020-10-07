import 'package:flutter/material.dart';

class ItemRow5 extends StatelessWidget {
  final String titleText;
  final String descriptionText;
  final String bodyText;
  final String labelText;
  final Widget indicator;
  final Widget secondaryIndicator;
  final bool withCard;
  final Function onTap;

  const ItemRow5({
    Key key,
    @required this.titleText,
    @required this.descriptionText,
    @required this.bodyText,
    @required this.labelText,
    this.indicator,
    this.secondaryIndicator,
    this.withCard = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _buildRow(context),
      onTap: onTap,
    );
  }

  Widget _buildRow(BuildContext context) {
    final content = _buildContent(context);
    if (withCard) {
      return Card(
        child: content,
      );
    }

    return content;
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildTitle(context),
              _buildDescription(context),
              _buildBody(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLabel(context),
                  secondaryIndicator ?? Container(),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: indicator ?? Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 40.0,
      ),
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        descriptionText,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        bodyText,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      labelText,
      style: Theme.of(context).textTheme.bodyText1.copyWith(
            color: Theme.of(context).primaryColor,
          ),
    );
  }
}
