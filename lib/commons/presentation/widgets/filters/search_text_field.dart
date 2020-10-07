import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String hintText;
  final Function(String value) onChanged;
  final Function(String value) onSubmitted;
  final Function onCancel;
  final bool isLoading;
  final double fontSize;
  const SearchTextField({
    Key key,
    @required this.hintText,
    this.onChanged,
    this.isLoading = false,
    this.onSubmitted,
    this.onCancel,
    this.fontSize = 14.0,
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;

  @override
  void initState() {
    _controller.addListener(_onChanged);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.search,
              color: Theme.of(context).accentColor,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: _onSubmitted,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.hintText,
              ),
              textInputAction: TextInputAction.search,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: widget.fontSize),
            ),
          ),
          _buildClearButton(),
          widget.isLoading
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  void _onChanged() {
    var value = _controller.text;
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }

    var showClear = value.trim().isNotEmpty;
    if (showClear != _showClear) {
      setState(() {
        _showClear = showClear;
      });
    }
  }

  Widget _buildClearButton() {
    if (!_showClear) return SizedBox.shrink();

    return IconButton(
      icon: Icon(
        Icons.close,
        color: Theme.of(context).accentColor,
      ),
      onPressed: _clearSearch,
    );
  }

  void _clearSearch() {
    if (widget.onCancel != null) {
      widget.onCancel();
    }
    _controller.text = '';
  }

  void _onSubmitted(String value) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted(value);
    }
  }
}
