import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ItemRow4 extends StatelessWidget {
  final String titleText;
  final String descriptionText;
  final String labelText;
  final Widget secondaryIndicator;
  final bool withCard;
  final Function onTap;
  final IconData iconRight;

  const ItemRow4({
    Key key,
    @required this.titleText,
    @required this.descriptionText,
    @required this.labelText,
    this.secondaryIndicator,
    this.withCard = true,
    this.onTap,
    this.iconRight,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return GestureDetector(
      child: _buildRow(context),
      onTap: onTap,
    );
  }

  Widget _buildRow(Object context) {
    var content = _buildContent(context);
    if (withCard) {
      return Card(child: content);
    }

    return content;
  }

  Padding _buildContent(Object context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitle(context),
                Icon(
                  iconRight ?? FlutterIcons.ios_arrow_forward_ion,
                )
              ],
            ),
            _buildDescription(context),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabel(context),
                secondaryIndicator ?? Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      titleText,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        descriptionText,
        style: Theme.of(context).textTheme.subtitle2,
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
