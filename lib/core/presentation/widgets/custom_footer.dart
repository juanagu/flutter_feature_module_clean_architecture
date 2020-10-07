import 'package:app/apps/default/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomFooter extends StatelessWidget {
  final Function onFacebookPressed;
  final Function onInstagramPressed;
  final Function onTermsAndConditions;

  const CustomFooter({
    Key key,
    @required this.onFacebookPressed,
    @required this.onInstagramPressed,
    @required this.onTermsAndConditions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(FlutterIcons.facebook_faw),
          onPressed: onFacebookPressed,
          color: Theme.of(context).primaryColorDark,
        ),
        IconButton(
          icon: Icon(FlutterIcons.instagram_mco),
          onPressed: onInstagramPressed,
          color: Theme.of(context).primaryColorDark,
        ),
        Flexible(
          child: _buildLabelButton(
            context,
            I18n.of(context).translate('terms_and_conditions'),
            onTermsAndConditions,
          ),
        ),
      ],
    );
  }

  FlatButton _buildLabelButton(
    BuildContext context,
    String title,
    Function onPressed,
  ) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
