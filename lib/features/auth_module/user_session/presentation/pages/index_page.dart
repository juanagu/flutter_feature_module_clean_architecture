import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/presentation/decorators/gradient_generator.dart';
import 'package:app/commons/presentation/widgets/indicators/activity_indicator.dart';
import 'package:app/features/auth_module/user_session/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndexPage extends StatefulWidget {
  final UserSessionBloc bloc;
  final Function(BuildContext context) onValidSession;
  final Function(BuildContext context) onInvalidSession;

  const IndexPage({
    Key key,
    this.onValidSession,
    this.onInvalidSession,
    this.bloc,
  }) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(CheckSession());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => widget.bloc,
      child: BlocConsumer<UserSessionBloc, UserSessionState>(
        cubit: widget.bloc,
        listener: _listenerByState,
        builder: _buildByState,
      ),
    );
  }

  void _listenerByState(
    BuildContext context,
    UserSessionState state,
  ) {
    if (state is ValidSession) {
      widget.onValidSession(context);
    } else if (state is InvalidSession) {
      widget.onInvalidSession(context);
    }
  }

  Widget _buildByState(
    BuildContext context,
    UserSessionState state,
  ) {
    return Stack(
      children: [
        GradientGenerator.buildBackground(context),
        ActivityIndicator(
          semanticsLabel: I18n.of(context).translate('init_app_semantic_label'),
          color: Colors.white,
        ),
      ],
    );
  }
}
