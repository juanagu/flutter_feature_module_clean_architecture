import 'dart:async';

import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/helpers/connectivity_helper.dart';
import 'package:app/commons/presentation/responsive/dimens.dart';
import 'package:app/commons/presentation/utils/snackbar_utils.dart';
import 'package:app/commons/presentation/widgets/forms/sign_in_form.dart';
import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';

typedef SignInSuccess = void Function(BuildContext context, UserLogged user);

class SignInMainWidget extends StatefulWidget {
  final bool withCard;
  final SignInBloc signInBloc;
  final SignInSuccess signInSuccess;
  final ConnectivityHelper connectivityHelper;

  const SignInMainWidget({
    Key key,
    @required this.signInBloc,
    this.withCard = false,
    this.signInSuccess,
    this.connectivityHelper,
  }) : super(key: key);

  @override
  _SignInMainWidgetState createState() => _SignInMainWidgetState();
}

class _SignInMainWidgetState extends State<SignInMainWidget> {
  final _globalSignInForm = GlobalKey<_SignInMainWidgetState>();
  StreamSubscription<bool> _connectivitySubscription;

  SignInFormController _controller;

  @override
  void initState() {
    super.initState();
    _subscribeToConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBloc();
  }

  @override
  void dispose() {
    _cancelSubscriptionToConnectivity();
    super.dispose();
  }

  void _subscribeToConnectivity() {
    if (widget.connectivityHelper != null) {
      _connectivitySubscription = widget.connectivityHelper
          .hasConnectionListen(_updateConnectionStatus);
    }
  }

  void _cancelSubscriptionToConnectivity() {
    if (_connectivitySubscription != null) {
      _connectivitySubscription.cancel();
    }
  }

  Future<void> _updateConnectionStatus(bool hasConnection) async {
    if (_controller != null) {
      _controller.setHasConnectivity(hasConnection);
    }
  }

  Widget _buildBloc() {
    return BlocProvider(
      key: Key('sign_in_main_widget'),
      create: (BuildContext context) => widget.signInBloc,
      child: BlocConsumer<SignInBloc, SignInState>(
        cubit: widget.signInBloc,
        listener: _listenerByState,
        builder: _buildByState,
      ),
    );
  }

  void _listenerByState(BuildContext context, SignInState state) {
    if (state is Authenticated && widget.signInSuccess != null) {
      widget.signInSuccess(context, state.user);
    }
    if (!(state is Authenticating) && _controller != null) {
      _controller.stopLoadingAndFocusUsername();
    }
    _checkErrorState(state);
  }

  Widget _buildByState(BuildContext context, SignInState state) {
    var form = _buildForm(context, state);

    if (widget.withCard) {
      return Card(
        child: form,
      );
    }

    return form;
  }

  Widget _buildForm(BuildContext context, SignInState state) {
    final i18n = I18n.of(context);
    return Container(
      child: Padding(
        padding: EdgeInsets.all(Dimens.of(context).toPoints(16.0)),
        child: SignInForm(
          key: _globalSignInForm,
          onSignIn: _onSignIn,
          signInButtonText: i18n.translate('sign_in'),
          usernameText: i18n.translate('username'),
          usernameRequiredMessageText: i18n.translate('username_is_required'),
          passwordText: i18n.translate('password'),
          passwordRequiredMessageText: i18n.translate('password_is_required'),
          onSignInFormControllerCreated: (controller) =>
              _controller = controller,
          withoutConnectivityText:
              i18n.translate('connectivity_error_button_message'),
          semanticsLoadingLabel:
              i18n.translate('sign_in_progress_semantic_label'),
        ),
      ),
    );
  }

  void _onSignIn(String username, String password) {
    var signInEvent = SignIn(
      username,
      password,
    );
    widget.signInBloc.add(signInEvent);
  }

  void _checkErrorState(SignInState state) {
    final message = _getErrorMessage(state);

    if (message != null && message.isNotEmpty) {
      _showErrorMessage(message);
    }
  }

  void _showErrorMessage(String message) {
    SnackBarUtils.showError(context, message);
  }

  String _getErrorMessage(SignInState state) {
    var message = '';

    if (state is Unauthenticated) {
      message = I18n.of(context).translate('sign_in_invalid_user_or_password');
    } else if (state is Failed) {
      message = state.error.toString();
    } else if (state is ConnectionError) {
      message =
          I18n.of(context).translate('connectivity_error_description_error');
    }

    return message;
  }
}
