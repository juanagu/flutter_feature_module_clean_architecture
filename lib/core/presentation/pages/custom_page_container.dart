import 'package:app/apps/default/i18n.dart';
import 'package:app/apps/custom_app/custom_app_urls.dart';
import 'package:app/commons/helpers/url_helper.dart';
import 'package:app/commons/presentation/widgets/containers/desktop_page_container.dart';
import 'package:app/commons/presentation/widgets/containers/mobile_page_container.dart';
import 'package:app/commons/presentation/widgets/navigations/user_logged_menu.dart';
import 'package:app/core/presentation/side_menu/mobile_custom_side_menu.dart';
import 'package:app/core/presentation/widgets/desktop_custom_app_bar.dart';
import 'package:app/core/presentation/widgets/custom_footer.dart';
import 'package:app/features/auth_module/sign_in/sign_in_feature.dart';
import 'package:app/features/auth_module/user_session/presentation/bloc/bloc.dart';
import 'package:app/features/auth_module/user_session/presentation/helpers/user_session_helper.dart';
import 'package:app/ioc/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomPageContainer extends StatelessWidget {
  final String title;
  final Widget body;
  final List<BreadcrumItem> breadcrumbItems;
  final bool withFooter;
  final bool withoutContentPadding;

  const CustomPageContainer({
    Key key,
    @required this.title,
    @required this.body,
    this.breadcrumbItems,
    this.withFooter = false,
    this.withoutContentPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: Injector.getInstance().resolve<UserSessionBloc>(),
      listener: _onStateChange,
      child: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => _buildMobilePage(context),
        tablet: (BuildContext context) => _buildDesktopPage(context),
      ),
    );
  }

  Widget _buildDesktopPage(BuildContext context) {
    return DesktopPageContainer(
      appBar: DesktopCustomAppBar(
        title: title,
        options: _getMenuOptions(context),
        onHomePressed: () {},
      ),
      breadcrumbItems: breadcrumbItems,
      body: body,
      footer: _buildFooter(),
      withoutContentPadding: withoutContentPadding,
    );
  }

  Widget _buildMobilePage(BuildContext context) {
    return MobilePageContainer(
      appBar: AppBar(
        title: Text(title),
      ),
      endDrawer: Drawer(
        child: MobileCustomSideMenu(
          options: _getMenuOptions(context),
        ),
      ),
      withoutContentPadding: withoutContentPadding,
      body: body,
    );
  }

  Widget _buildFooter() => CustomFooter(
        onFacebookPressed: _onFacebookPressed,
        onInstagramPressed: _onInstagramPressed,
        onTermsAndConditions: _onTermsAndConditions,
      );

  List<MenuOption> _getMenuOptions(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    var logoutOption = MenuOption(I18n.of(context).translate('sign_off'),
        () => _onSignOff(context), null);

    switch (deviceType) {
      case DeviceScreenType.mobile:
        return [
          MenuOption(
            I18n.of(context).translate('facebook'),
            _onFacebookPressed,
            FlutterIcons.facebook_faw,
          ),
          MenuOption(
            I18n.of(context).translate('instagram'),
            _onInstagramPressed,
            FlutterIcons.instagram_faw,
          ),
          MenuOption(
            I18n.of(context).translate('terms_and_conditions'),
            _onTermsAndConditions,
            null,
          ),
          logoutOption
        ];
      default:
        return [
          logoutOption,
        ];
    }
  }

  void _onSignOff(BuildContext context) {
    var userSesionHelper = Injector.getInstance().resolve<UserSessionHelper>();
    userSesionHelper.logout(context);
  }

  void _onStateChange(BuildContext context, UserSessionState state) {
    if (state is InvalidSession) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(SignInFeature.Route, (route) => false);
    }
  }

  void _onFacebookPressed() {
    _openUrl(EngineAdminUrls.facebook);
  }

  void _onInstagramPressed() {
    _openUrl(EngineAdminUrls.instagram);
  }

  void _onTermsAndConditions() {
    _openUrl(EngineAdminUrls.termsAndConditions);
  }

  void _openUrl(String url) {
    Injector.getInstance().resolve<UrlHelper>().openUrl(url);
  }
}
