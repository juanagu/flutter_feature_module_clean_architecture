import 'package:flutter/material.dart';
export 'side_header_profile_menu.dart';
export 'side_footer_version_menu.dart';

class SideMenu extends StatelessWidget {
  final Widget header;
  final Widget body;
  final Widget footer;
  final Color backgroundColor;

  const SideMenu({
    Key key,
    this.header,
    this.body,
    this.footer,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            header ?? Container(),
            Expanded(
              child: body ?? Container(),
            ),
            footer ?? Container(),
          ],
        ),
      ),
    );
  }
}
