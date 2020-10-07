import 'package:app/apps/default/i18n.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CopyrightView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.overline.copyWith(
          color: Theme.of(context).primaryColorDark,
        );
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      var isMobile =
          sizingInformation.deviceScreenType == DeviceScreenType.mobile;
      var ownerMessageKey =
          isMobile ? 'copyright_owner' : 'copyright_owner_extended';

      return Container(
        height: 40.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment:
                isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Text(
                I18n.of(context).translate('copyright_year'),
                style: textStyle,
              ),
              SizedBox(width: 8.0),
              Text(
                I18n.of(context).translate(ownerMessageKey),
                style: textStyle,
              ),
            ],
          ),
        ),
      );
    });
  }
}
