import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NotFoundPage extends StatelessWidget {
  final String initialRoute;

  const NotFoundPage({
    Key key,
    @required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('404', style: theme.textTheme.headline3),
              Text(
                I18n.of(context).translate('not_found_message'),
                style: theme.textTheme.bodyText1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FlutterIcons.alert_circle_outline_mco,
                  size: 150.0,
                  color: theme.primaryColorDark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _buildActions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    var withBack = Navigator.of(context).canPop();
    var goToHomeButton = PrimaryButton(
      titleText: I18n.of(context).translate('go_to_init'),
      onPressed: () => Navigator.of(context).pushNamed(initialRoute),
    );

    if (!withBack) return goToHomeButton;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryButton(
          titleText: I18n.of(context).translate('back'),
          onPressed: () => Navigator.of(context).pop(),
          outline: true,
        ),
        SizedBox(
          width: 16.0,
        ),
        goToHomeButton,
      ],
    );
  }
}
