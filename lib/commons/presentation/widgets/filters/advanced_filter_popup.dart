import 'package:app/apps/default/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'advanced_filter.dart';

class AdvancedFilterPopup extends StatefulWidget {
  final double width;
  final AdvancedFilterSearch onSearch;
  final Function onClear;

  const AdvancedFilterPopup({
    Key key,
    @required this.width,
    @required this.onSearch,
    @required this.onClear,
  }) : super(key: key);

  @override
  _AdvancedFilterPopupState createState() => _AdvancedFilterPopupState();
}

class _AdvancedFilterPopupState extends State<AdvancedFilterPopup>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final List<OverlayEntry> _overlays = [];
  int _widthSize = -1;

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
    _closeDatePickerWhenIsResize();
    return InkWell(
      onTap: _openOrCloseFilter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(I18n.of(context).translate('filter')),
            RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(_animationController),
              child: Icon(
                FlutterIcons.chevron_down_mco,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openOrCloseFilter() {
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
        onTap: _openOrCloseFilter,
        child: Stack(
          children: [
            Positioned(
              left: _calculateLeftPosition(offset),
              top: offset.dy + size.height + 15.0,
              width: widget.width,
              child: Material(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(18.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AdvancedFilter(
                    onSearch: _onSearch,
                    onClear: _onClear,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double _calculateLeftPosition(Offset offset) {
    var isMobile =
        getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.mobile;
    if (isMobile) return 0;
    return offset.dx - widget.width;
  }

  void _closeDatePickerWhenIsResize() {
    if (_widthSize == -1) {
      _widthSize = MediaQuery.of(context).size.width.toInt();
    }
    if (_widthSize != MediaQuery.of(context).size.width.toInt()) {
      if (_overlays.isNotEmpty) {
        _animationController.reverse();
      }
      _closeOverlay();
      _widthSize = MediaQuery.of(context).size.width.toInt();
    }
  }

  void _onSearch(AdvancedFilterResult result) {
    _openOrCloseFilter();
    widget.onSearch(result);
  }

  void _onClear() {
    _openOrCloseFilter();
    widget.onClear();
  }
}
