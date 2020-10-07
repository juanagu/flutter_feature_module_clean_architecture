import 'package:app/apps/custom_app/custom_app_themes.dart';
import 'package:app/commons/presentation/responsive/dimens.dart';
import 'package:flutter/material.dart';

class DesktopPageContainer extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Widget footer;
  final List<BreadcrumItem> breadcrumbItems;
  final bool withoutContentPadding;

  const DesktopPageContainer({
    Key key,
    this.appBar,
    @required this.body,
    this.footer,
    this.breadcrumbItems,
    this.withoutContentPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contentPadding = Dimens.of(context).contentPadding;
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            appBar ?? SizedBox.shrink(),
            _buildNavigationItems(context, contentPadding),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: withoutContentPadding
                        ? EdgeInsets.zero
                        : contentPadding,
                    child: body,
                  ),
                ],
              ),
            ),
            _buildFooter(contentPadding),
            /*Padding(
              padding: contentPadding,
              child: CopyrightView(),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(EdgeInsets contentPadding) {
    if (footer == null) return SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: CustomAppThemes.properties().footerColor,
      child: Padding(
        padding: contentPadding,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: footer,
        ),
      ),
    );
  }

  Widget _buildNavigationItems(
    BuildContext context,
    EdgeInsets contentPadding,
  ) {
    if (breadcrumbItems == null || breadcrumbItems.isEmpty) {
      return SizedBox.shrink();
    }

    var index = 0;
    return Container(
      color: CustomAppThemes.properties().breadcrumbBackgroundColor,
      child: Padding(
        padding: contentPadding,
        child: Row(
          children: breadcrumbItems.map((e) {
            var widget =
                e.toWidget(context, index < breadcrumbItems.length - 1);
            index++;
            return widget;
          }).toList(),
        ),
      ),
    );
  }
}

class BreadcrumItem {
  final String title;
  final Function onPressed;

  BreadcrumItem(
    this.title,
    this.onPressed,
  );

  Widget toWidget(BuildContext context, bool isHistory) {
    var textStyle =
        Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 14.0);
    var color = Theme.of(context).primaryColorDark;
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 12.0, bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: isHistory
                  ? textStyle
                  : textStyle.copyWith(
                      color: color,
                    ),
            ),
            isHistory
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.0,
                      color: color,
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
