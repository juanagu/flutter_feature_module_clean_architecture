import 'package:app/commons/presentation/widgets/app_bars/web_app_bar_01.dart';
import 'package:app/commons/presentation/widgets/navigations/user_logged_menu.dart';
import 'package:flutter/material.dart';

class DesktopCustomAppBar extends StatelessWidget {
  final String title;
  final List<MenuOption> options;
  final Function onHomePressed;

  const DesktopCustomAppBar({
    Key key,
    @required this.title,
    @required this.options,
    @required this.onHomePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      shadowColor: Color(0xFF083362),
      child: WebAppBar01(
        leading: GestureDetector(
          onTap: onHomePressed,
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(
              Icons.apps,
              color: Theme.of(context).accentColor,
              size: 60.0,
            ),
          ),
        ),
        title: title,
        action: UserLoggedMenu(
          options: options,
        ),
      ),
    );
  }
}
