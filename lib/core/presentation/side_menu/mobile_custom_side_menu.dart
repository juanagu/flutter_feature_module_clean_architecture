import 'package:app/commons/presentation/widgets/navigations/side_menu/side_menu.dart';
import 'package:app/commons/presentation/widgets/navigations/side_menu/simpe_header_profile_menu.dart';
import 'package:app/commons/presentation/widgets/navigations/user_logged_menu.dart';
import 'package:flutter/material.dart';

class MobileCustomSideMenu extends StatelessWidget {
  final List<MenuOption> options;

  const MobileCustomSideMenu({
    Key key,
    @required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SideMenu(
        backgroundColor: Theme.of(context).backgroundColor,
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildCloseButton(context),
              SizedBox(height: 24.0),
              SimpleHeaderProfileMenu(),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildOptions(context),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () => _close(context),
    );
  }

  void _close(BuildContext context) => Navigator.of(context).pop();

  Widget _buildOptions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView.separated(
        itemBuilder: _buildOptionItem,
        itemCount: options.length,
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, int index) {
    var option = options[index];
    return ListTile(
      leading: option.leadingIcon != null
          ? Icon(option.leadingIcon, color: Theme.of(context).accentColor)
          : null,
      title: Text(option.title),
      onTap: () {
        _close(context);
        option.onPressed();
      },
    );
  }
}
