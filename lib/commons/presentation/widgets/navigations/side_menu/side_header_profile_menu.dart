import 'package:flutter/material.dart';

class SideHeaderProfileMenu extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final profileImage;
  final profileImageSize;
  final Widget profileAction;
  final Function onTapped;

  const SideHeaderProfileMenu({
    Key key,
    this.height,
    this.backgroundColor,
    this.profileImage,
    this.profileImageSize = 80.0,
    this.profileAction,
    this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = Colors.white;
    var horizontalPadding = 16.0;
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        height: height,
        color: backgroundColor ?? Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: [
              CircleAvatar(
                radius: profileImageSize / 2,
                child: profileImage,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Title',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: textColor),
                    ),
                    Text(
                      'Subtitle',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: textColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
