import 'package:app/features/auth_module/user_session/presentation/bloc/bloc.dart';
import 'package:app/ioc/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class UserLoggedMenu extends StatefulWidget {
  final List<MenuOption> options;

  UserLoggedMenu({
    Key key,
    @required this.options,
  }) : super(key: key);

  @override
  _UserLoggedMenuState createState() => _UserLoggedMenuState();
}

class _UserLoggedMenuState extends State<UserLoggedMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  final List<OverlayEntry> _overlays = [];

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _buildAvatar(),
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 8.0,
            ),
            child: _buildUserLoggedName(context),
          ),
          RotationTransition(
            turns: Tween(begin: 0.0, end: 0.5).animate(_animationController),
            child: IconButton(
              icon: Icon(
                FlutterIcons.chevron_down_mco,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => _onArrowPressed(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserLoggedName(BuildContext context) {
    return BlocBuilder<UserSessionBloc, UserSessionState>(
      cubit: Injector.getInstance().resolve<UserSessionBloc>()
        ..add(CheckSession()),
      builder: (context, state) {
        if (state is ValidSession) {
          var theme = Theme.of(context);
          return Text(
            state.userInfo.fullName,
            style: theme.appBarTheme.textTheme.headline5
                .copyWith(color: theme.primaryColorDark),
          );
        }

        return SizedBox(
          height: 18.0,
          width: 18.0,
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return Icon(
      FlutterIcons.person_outline_mdi,
      color: Theme.of(context).accentColor,
      size: 30.0,
    );
  }

  void _onArrowPressed(BuildContext context) {
    if (_overlays.isEmpty) {
      _animationController.forward();

      var overlay = _createOverlayEntry(context);
      _overlays.add(overlay);
      Overlay.of(context).insert(overlay);
    } else {
      _animationController.reverse();
      _closeOverlay();
    }
  }

  void _closeOverlay() {
    if (_overlays.isNotEmpty) {
      _overlays.first.remove();
      _overlays.clear();
    }
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _onArrowPressed(context),
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 15.0,
              width: size.width,
              child: Material(
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(18.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: _buildMenuItem,
                    itemCount: widget.options.length,
                    separatorBuilder: _buildSeparator,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, int index) {
    var option = widget.options[index];
    return ListTile(
      title: Text(
        option.title,
        style: Theme.of(context).textTheme.overline,
        textAlign: TextAlign.start,
      ),
      onTap: () => _onPressedOption(option),
    );
  }

  Widget _buildSeparator(BuildContext context, int index) {
    return Divider(
      height: 4,
    );
  }

  void _onPressedOption(MenuOption option) {
    _onArrowPressed(context);
    option.onPressed();
  }
}

class MenuOption {
  final String title;
  final Function onPressed;
  final IconData leadingIcon;

  MenuOption(
    this.title,
    this.onPressed,
    this.leadingIcon,
  );
}
