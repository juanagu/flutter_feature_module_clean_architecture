import 'package:flutter/material.dart';
import 'package:app/commons/extensions/date_time_extensions.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:responsive_builder/responsive_builder.dart';

class DatePickerField extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final Function(DateTime date) onSelected;

  const DatePickerField({
    Key key,
    this.initialDate,
    this.minDate,
    this.maxDate,
    @required this.label,
    this.onSelected,
  }) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<OverlayEntry> _overlays = [];
  int _widthSize = -1;
  DateTime _selectedDate;

  @override
  void initState() {
    _setInitDate();

    super.initState();
  }

  void _setInitDate() {
    if (widget.initialDate != null) {
      _textEditingController..text = widget.initialDate.formatToDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    _closeDatePickerWhenIsResize();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 18.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                minHeight: 32,
                minWidth: 22,
              ),
              contentPadding: const EdgeInsets.all(8.0),
            ),
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
            focusNode: AlwaysDisabledFocusNode(),
            controller: _textEditingController,
            onTap: () {
              _openDatePicker();
            },
          ),
        ),
      ],
    );
  }

  void _setNewSelectedDate(DateTime newSelectedDate) {
    _closeDatePicker();
    _selectedDate = newSelectedDate;
    _textEditingController
      ..text = _selectedDate.formatToDate()
      ..selection = TextSelection.fromPosition(
        TextPosition(
          offset: _textEditingController.text.length,
          affinity: TextAffinity.upstream,
        ),
      );

    if (widget.onSelected != null) {
      widget.onSelected(newSelectedDate);
    }
  }

  DateTime _getInitialDate() {
    if (_selectedDate != null) return _selectedDate;
    if (widget.initialDate != null) return widget.initialDate;

    return DateTime.now();
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeDatePicker,
        child: Stack(
          children: [
            Positioned(
              left: _calculateLeftPosition(offset),
              top: offset.dy + size.height + 2.0,
              child: Material(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(18.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: dp.DayPicker(
                    selectedDate: _getInitialDate(),
                    firstDate: widget.minDate ?? DateTime(2000),
                    lastDate: widget.maxDate ?? DateTime.now(),
                    onChanged: _setNewSelectedDate,
                    datePickerStyles: dp.DatePickerRangeStyles(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openDatePicker() {
    var overlay = _createOverlayEntry(context);
    _overlays.add(overlay);
    Overlay.of(context).insert(overlay);
  }

  void _closeDatePicker() {
    if (_overlays.isNotEmpty) {
      _overlays.first.remove();
      _overlays.clear();
    }
  }

  void _closeDatePickerWhenIsResize() {
    if (_widthSize == -1) {
      _widthSize = MediaQuery.of(context).size.width.toInt();
    }
    if (_widthSize != MediaQuery.of(context).size.width.toInt()) {
      _closeDatePicker();
      _widthSize = MediaQuery.of(context).size.width.toInt();
    }
  }

  double _calculateLeftPosition(Offset offset) {
    var isMobile =
        getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.mobile;
    if (isMobile) return 0;
    return offset.dx;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
