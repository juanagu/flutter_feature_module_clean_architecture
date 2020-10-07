import 'package:app/commons/helpers/app_version_info.dart';
import 'package:flutter/material.dart';

class SideFooterVersionMenu extends StatelessWidget {
  final AppVersionInfo appVersionInfo;

  SideFooterVersionMenu({
    Key key,
    this.appVersionInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Divider(
          height: 2.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: Text(
            'v${appVersionInfo.version}',
            style: Theme.of(context).textTheme.overline,
          ),
        )
      ],
    );
  }
}
