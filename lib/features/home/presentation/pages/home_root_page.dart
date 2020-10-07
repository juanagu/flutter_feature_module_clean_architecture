import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/helpers/app_version_info.dart';
import 'package:app/core/presentation/pages/custom_page_container.dart';
import 'package:flutter/material.dart';

class HomeRootPage extends StatelessWidget {
  final AppVersionInfo appVersionInfo;
  final Widget Function() buildWidget;

  const HomeRootPage({
    Key key,
    this.appVersionInfo,
    @required this.buildWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPageContainer(
      title: I18n.of(context).translate('start'),
      body: buildWidget(),
      withFooter: true,
    );
  }
}
