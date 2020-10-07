import 'package:app/commons/presentation/utils/keyboard_utils.dart';
import 'package:app/commons/presentation/widgets/buttons/primary_button.dart';
import 'package:app/commons/presentation/widgets/fields/custom_text_form_field.dart';
import 'package:app/commons/presentation/widgets/indicators/activity_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

typedef SignInCallback = void Function(String username, String password);
typedef SignInFormControllerCreated = void Function(
    SignInFormController controller);

class SignInForm extends StatefulWidget {
  final String usernameText;
  final String passwordText;
  final String usernameRequiredMessageText;
  final String passwordRequiredMessageText;
  final String signInButtonText;
  final SignInCallback onSignIn;
  final SignInFormControllerCreated onSignInFormControllerCreated;
  final String withoutConnectivityText;
  final String semanticsLoadingLabel;

  SignInForm({
    Key key,
    this.onSignIn,
    @required this.signInButtonText,
    @required this.usernameText,
    @required this.passwordText,
    @required this.usernameRequiredMessageText,
    @required this.passwordRequiredMessageText,
    this.onSignInFormControllerCreated,
    this.withoutConnectivityText,
    this.semanticsLoadingLabel,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isBusy = false;
  bool _isError = false;
  bool _hasConnectivity = true;

  @override
  void initState() {
    super.initState();
    onCreated();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUsernameTextField(),
          SizedBox(
            height: 15.0,
          ),
          _buildPasswordTextField(),
          SizedBox(
            height: 30.0,
          ),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    if (!_hasConnectivity) {
      return PrimaryButton(
        key: Key('sign_in_button'),
        expanded: true,
        titleText: widget.withoutConnectivityText ?? 'No internet.',
      );
    }

    if (_isBusy) {
      return ActivityIndicator(
        semanticsLabel: widget.semanticsLoadingLabel,
      );
    }

    return RawKeyboardListener(
      onKey: (key) {
        if (KeyboardUtils.isEnter(key)) {
          _onSignIn();
        }
      },
      focusNode: FocusNode(),
      child: PrimaryButton(
        key: Key('sign_in_button'),
        titleText: widget.signInButtonText,
        expanded: true,
        onPressed: _onSignIn,
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return CustomTextFormTextField(
      key: Key('sign_in_username'),
      enabled: !_isBusy,
      focusNode: _usernameFocusNode,
      labelText: widget.usernameText,
      iconData: FlutterIcons.person_outline_mdi,
      controller: _usernameTextEditingController,
      validator: _usernameValidator,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        if (_isError) {
          _formKey.currentState.validate();
        }

        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget _buildPasswordTextField() {
    return CustomTextFormTextField(
      key: Key('sign_in_password'),
      enabled: !_isBusy,
      focusNode: _passwordFocusNode,
      labelText: widget.passwordText,
      iconData: FlutterIcons.lock_outline_mdi,
      validator: _passwordValidator,
      controller: _passwordTextEditingController,
      isPassword: true,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => _onSignIn(),
    );
  }

  void onCreated() {
    if (widget.onSignInFormControllerCreated != null) {
      widget.onSignInFormControllerCreated(
        SignInFormController(
          _stopLoadingAndFocusUsername,
          _setHasConnectivity,
        ),
      );
    }
  }

  String _passwordValidator(String value) {
    if (value.trim().isEmpty) {
      return widget.passwordRequiredMessageText;
    }

    return null;
  }

  String _usernameValidator(String value) {
    if (value.trim().isEmpty) {
      return widget.usernameRequiredMessageText;
    }

    return null;
  }

  void _onSignIn() {
    if (_hasConnectivity) {
      final isValid = _validateForm();

      final username = _usernameTextEditingController.text.trim();
      final password = _passwordTextEditingController.text.trim();

      if (isValid && widget.onSignIn != null) {
        _loading();
        widget.onSignIn(username, password);
      }
      _focusRequiredTextfield(username, password);
    }
  }

  bool _validateForm() {
    var isValid = _formKey.currentState.validate();
    _isError = !isValid;
    return isValid;
  }

  void _focusRequiredTextfield(String username, String password) {
    if (username.isEmpty) {
      _focusUsername();
    } else if (password.isEmpty) {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    }
  }

  void _focusUsername() {
    FocusScope.of(context).requestFocus(_usernameFocusNode);
  }

  void _loading() {
    setState(() {
      _isBusy = true;
    });
  }

  void _stopLoadingAndFocusUsername() {
    setState(() {
      _isBusy = false;
    });
  }

  void _setHasConnectivity(bool hasConnectivity) {
    if (_hasConnectivity != hasConnectivity) {
      setState(() {
        _hasConnectivity = hasConnectivity;
      });
    }
  }
}

class SignInFormController {
  final Function stopLoadingAndFocusUsername;
  final Function(bool hasConnectivity) setHasConnectivity;

  SignInFormController(
      this.stopLoadingAndFocusUsername, this.setHasConnectivity);
}
