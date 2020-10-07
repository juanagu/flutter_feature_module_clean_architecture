import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/presentation/widgets/buttons/primary_button.dart';
import 'package:app/commons/presentation/widgets/fields/date_picker_field.dart';
import 'package:flutter/material.dart';

typedef AdvancedFilterSearch = void Function(AdvancedFilterResult result);

class AdvancedFilter extends StatefulWidget {
  final AdvancedFilterSearch onSearch;
  final Function() onClear;

  const AdvancedFilter({
    Key key,
    @required this.onSearch,
    @required this.onClear,
  }) : super(key: key);

  @override
  _AdvancedFilterState createState() => _AdvancedFilterState();
}

class _AdvancedFilterState extends State<AdvancedFilter> {
  DateTime _fromDate;
  DateTime _toDate = DateTime.now();
  bool _withReturnOperation = true;
  bool _withPurchaseOperation = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDateFilters(),
          SizedBox(height: 8.0),
          _buildCheckboxes(),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildDateFilters() {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: DatePickerField(
            label: I18n.of(context).translate('date_filter_from'),
            initialDate: _fromDate,
            onSelected: _onSelectedFromDate,
          ),
        ),
        Spacer(),
        Expanded(
          flex: 10,
          child: DatePickerField(
            label: I18n.of(context).translate('date_filter_to'),
            initialDate: _toDate,
            onSelected: _onSelectedToDate,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 8,
          child: _buildCheckbox(
            'return',
            _withReturnOperation,
            (value) {
              setState(() {
                _withReturnOperation = value;
              });
            },
          ),
        ),
        Flexible(
          flex: 7,
          child: _buildCheckbox(
            'purchase',
            _withPurchaseOperation,
            (value) {
              setState(() {
                _withPurchaseOperation = value;
              });
            },
          ),
        ),
        Spacer(
          flex: 6,
        ),
      ],
    );
  }

  Widget _buildActions() {
    var i18n = I18n.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PrimaryButton(
          titleText: i18n.translate('filter_clear'),
          tiny: true,
          outline: true,
          onPressed: _clearFilters,
        ),
        SizedBox(width: 8.0),
        PrimaryButton(
          titleText: i18n.translate('filter_search'),
          tiny: true,
          onPressed: _search,
        ),
      ],
    );
  }

  Widget _buildCheckbox(
    String titleKey,
    bool value,
    Function(bool value) onChanged,
  ) {
    return CheckboxListTile(
      title: Text(
        I18n.of(context).translate(titleKey),
        style: Theme.of(context).textTheme.caption,
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 2.0),
    );
  }

  void _onSelectedFromDate(DateTime date) {
    setState(() {
      _fromDate = date;
    });
    if (_fromDate.compareTo(_toDate) > 0) {
      setState(() {
        _fromDate = _fromDate;
      });
    }
  }

  void _onSelectedToDate(DateTime date) {
    setState(() {
      _toDate = date;
    });
  }

  void _clearFilters() {
    widget.onClear();
  }

  void _search() {
    var result = AdvancedFilterResult(
      _fromDate,
      _toDate,
      _withReturnOperation,
      _withPurchaseOperation,
    );
    widget.onSearch(result);
  }
}

class AdvancedFilterResult {
  final DateTime fromDate;
  final DateTime toDate;
  final bool withReturn;
  final bool withPurchase;

  AdvancedFilterResult(
    this.fromDate,
    this.toDate,
    this.withReturn,
    this.withPurchase,
  );
}
