import 'package:app/commons/presentation/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomTextFormTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final IconData iconData;
  final bool isPassword;
  final FormFieldValidator<String> validator;
  final Function(String value) onChanged;
  final Function(String value) onFieldSubmitted;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final int maxLines;
  final bool enabled;
  final TextInputType keyboardType;
  final bool autofocus;

  const CustomTextFormTextField({
    Key key,
    @required this.labelText,
    this.controller,
    this.iconData,
    this.validator,
    this.isPassword = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.maxLines = 1,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _CustomTextFormTextFieldState createState() =>
      _CustomTextFormTextFieldState();
}

class _CustomTextFormTextFieldState extends State<CustomTextFormTextField> {
  bool _isObscureText = false;

  @override
  void initState() {
    super.initState();
    _isObscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      decoration: _buildDecoration(),
      maxLines: widget.maxLines,
      controller: widget.controller,
      obscureText: _isObscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.bodyText1,
      autofocus: widget.autofocus,
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      icon: _buildIcon(),
      labelText: widget.labelText,
      labelStyle: Theme.of(context).textTheme.bodyText1,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: widget.isPassword ? _buildPasswordIcon() : null,
    );
  }

  Icon _buildIcon() {
    return widget.iconData != null
        ? Icon(
            widget.iconData,
          )
        : null;
  }

  Widget _buildPasswordIcon() {
    var iconData = _isObscureText
        ? FlutterIcons.eye_off_outline_mco
        : FlutterIcons.eye_outline_mco;
    return RawKeyboardListener(
      key: UniqueKey(),
      onKey: (key) {
        if (KeyboardUtils.isEnter(key)) {
          _onPasswordVisibilityChange();
        }
      },
      focusNode: FocusNode(),
      child: ExcludeSemantics(
        child: IconButton(
          onPressed: _onPasswordVisibilityChange,
          icon: Icon(
            iconData,
          ),
        ),
      ),
    );
  }

  void _onPasswordVisibilityChange() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }
}
