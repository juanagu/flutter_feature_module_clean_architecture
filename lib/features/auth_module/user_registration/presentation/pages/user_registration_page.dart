import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/presentation/widgets/containers/desktop_page_container.dart';
import 'package:app/core/presentation/pages/custom_page_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserRegistrationPage extends StatelessWidget {
  final Widget Function() buildForm;
  final bool withBreadcrums;

  const UserRegistrationPage({
    Key key,
    @required this.buildForm,
    this.withBreadcrums = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPageContainer(
      title: I18n.of(context).translate('registration'),
      withoutContentPadding: true,
      body: _buildForm(context),
      breadcrumbItems: withBreadcrums ? _buildBreadcrumbItems(context) : null,
    );
  }

  Widget _buildForm(BuildContext context) {
    var form = buildForm();
    return ScreenTypeLayout(
      mobile: Padding(
        padding: const EdgeInsets.all(16.0),
        child: form,
      ),
      tablet: Center(
        child: form,
      ),
    );
  }

  List<BreadcrumItem> _buildBreadcrumbItems(BuildContext context) {
    var i18n = I18n.of(context);
    return [
      BreadcrumItem(i18n.translate('start'), () => Navigator.of(context).pop()),
      BreadcrumItem(i18n.translate('register'), () {}),
    ];
  }
}
