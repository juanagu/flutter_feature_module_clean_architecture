import 'package:app/commons/presentation/responsive/dimens.dart';
import 'package:flutter/material.dart';

class MobilePageContainer extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final Drawer endDrawer;
  final bool withoutContentPadding;

  const MobilePageContainer({
    Key key,
    this.appBar,
    @required this.body,
    this.endDrawer,
    this.withoutContentPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      endDrawer: endDrawer,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: withoutContentPadding
                  ? EdgeInsets.zero
                  : Dimens.of(context).contentPadding,
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
