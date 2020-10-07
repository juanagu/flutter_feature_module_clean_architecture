import 'dart:async';

import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/helpers/connectivity_helper.dart';
import 'package:app/commons/presentation/utils/snackbar_utils.dart';
import 'package:app/commons/presentation/widgets/buttons/primary_button.dart';
import 'package:app/commons/presentation/widgets/fields/custom_text_form_field.dart';
import 'package:app/core/domain/entities/user.dart';
import 'package:app/features/auth_module/user_registration/domain/value_objects/user_registration.dart';
import 'package:app/features/auth_module/user_registration/presentation/bloc/user_registration_bloc.dart';
import 'package:app/features/auth_module/user_registration/presentation/validators/user_registration_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserRegistrationForm extends StatefulWidget {
  final Function(BuildContext context, User user) onSuccess;
  final UserRegistrationBloc bloc;
  final ConnectivityHelper connectivityHelper;
  UserRegistrationForm({
    Key key,
    @required this.onSuccess,
    @required this.bloc,
    @required this.connectivityHelper,
  }) : super(key: key);

  @override
  _UserRegistrationFormState createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isBusy = false;
  UserRegistrationValidator userRegistrationValidator;
  StreamSubscription<bool> _connectivitySubscription;
  bool _hasConnection = true;

  @override
  void initState() {
    userRegistrationValidator = UserRegistrationValidator(context);
    _subscribeToConnectivity();
    _checkConnection();
    super.initState();
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
    _setHasConnection(hasConnection);
  }

  void _setHasConnection(bool hasConnection) {
    setState(() {
      _hasConnection = hasConnection;
    });
  }

  Future<void> _checkConnection() async {
    var hasConnection = await widget.connectivityHelper.hasConnection();
    _setHasConnection(hasConnection);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Card(
        child: _buildForm(context),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      I18n.of(context).translate('user_registration_subtitle'),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildForm(BuildContext context) {
    return BlocListener<UserRegistrationBloc, UserRegistrationState>(
      cubit: widget.bloc,
      listener: _listenerByState,
      child: BlocBuilder<UserRegistrationBloc, UserRegistrationState>(
        cubit: widget.bloc,
        builder: (context, state) {
          isBusy = state is Uploading;
          return Form(
            key: _formKey,
            child: ScreenTypeLayout(
              mobile: _buildMobileContent(context),
              tablet: _buildDesktopContent(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    var contentWidth = _getDesktopContentWidth(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        width: contentWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubtitle(context),
            _buildRow(
              context,
              _buildFirstName(context),
              _buildLastName(context),
            ),
            _buildRow(
              context,
              _buildIdentifier(context),
              _buildPhoneOrCellphone(context),
            ),
            _buildRow(
              context,
              _buildEmail(context),
              Stack(children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _buildSubmitButton(context, false),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  double _getDesktopContentWidth(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var aspect = 0.85;
    if (width > 1400) {
      aspect = 0.6;
    } else if (width > 1200) {
      aspect = 0.65;
    } else if (width > 1000) {
      aspect = 0.75;
    } else if (width > 800) {
      aspect = 0.8;
    }

    return width * aspect;
  }

  Widget _buildRow(BuildContext context, Widget left, Widget right) {
    const widthFactor = 0.45;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(widthFactor: widthFactor, child: left),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FractionallySizedBox(widthFactor: widthFactor, child: right),
          )
        ],
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSubtitle(context),
          _buildFirstName(context),
          _buildLastName(context),
          _buildIdentifier(context),
          _buildPhoneOrCellphone(context),
          _buildEmail(context),
          SizedBox(
            height: 16.0,
          ),
          _buildSubmitButton(context, true)
        ],
      ),
    );
  }

  Widget _buildFirstName(BuildContext context) {
    return CustomTextFormTextField(
      iconData: FlutterIcons.person_outline_mdi,
      labelText: I18n.of(context).translate('first_name'),
      validator: userRegistrationValidator.validateFirstName,
      textInputAction: TextInputAction.next,
      autofocus: true,
      controller: _firstNameController,
      enabled: !isBusy,
    );
  }

  Widget _buildLastName(BuildContext context) {
    return CustomTextFormTextField(
      iconData: FlutterIcons.person_outline_mdi,
      labelText: I18n.of(context).translate('last_name'),
      validator: userRegistrationValidator.validateLastName,
      textInputAction: TextInputAction.next,
      controller: _lastNameController,
      enabled: !isBusy,
    );
  }

  Widget _buildIdentifier(BuildContext context) {
    return CustomTextFormTextField(
      iconData: FlutterIcons.credit_card_outline_mco,
      labelText: I18n.of(context).translate('identifier'),
      validator: userRegistrationValidator.validateIdentifier,
      textInputAction: TextInputAction.next,
      controller: _identifierController,
      enabled: !isBusy,
    );
  }

  Widget _buildPhoneOrCellphone(BuildContext context) {
    return CustomTextFormTextField(
      iconData: Icons.phone_android_outlined,
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      labelText: I18n.of(context).translate('phone_or_cellphone'),
      validator: userRegistrationValidator.validatePhoneOrCellphone,
      textInputAction: TextInputAction.next,
      controller: _phoneController,
      enabled: !isBusy,
    );
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormTextField(
      iconData: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      labelText: I18n.of(context).translate('email_optional'),
      validator: userRegistrationValidator.validateEmail,
      textInputAction: TextInputAction.send,
      controller: _emailController,
      enabled: !isBusy,
    );
  }

  Widget _buildSubmitButton(BuildContext context, bool expanded) {
    var titleTextKey =
        _hasConnection ? 'register' : 'connectivity_error_button_message';
    return PrimaryButton(
      titleText: I18n.of(context).translate(titleTextKey),
      onPressed: _hasConnection ? _onSignUp : null,
      expanded: expanded,
      isBusy: isBusy,
    );
  }

  void _onSignUp() {
    if (_formKey.currentState.validate() && _hasConnection) {
      widget.bloc.register(
        _getUserRegistration(),
      );
    }
  }

  UserRegistration _getUserRegistration() {
    var email = _emailController.value.text;
    return UserRegistration(
        _firstNameController.value.text,
        _lastNameController.value.text,
        _identifierController.value.text,
        _phoneController.value.text,
        email: email.trim().isNotEmpty ? email : null);
  }

  void _listenerByState(BuildContext context, UserRegistrationState state) {
    if (state is Success) {
      widget.onSuccess(context, state.user);
    } else if (state is Error) {
      SnackBarUtils.showError(
        context,
        I18n.of(context).translate('user_registration_error_message'),
      );
    }
  }
}
