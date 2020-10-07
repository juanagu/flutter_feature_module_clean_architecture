import 'package:app/features/auth_module/core/domain/respositories/user_session_repository.dart';
import 'package:app/features/auth_module/user_session/domain/use_cases/get_user_info_use_case.dart';
import 'package:app/features/auth_module/user_session/presentation/bloc/user_session_event.dart';
import 'package:app/features/auth_module/user_session/presentation/bloc/user_session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  final GetUserInfoUseCase _getCompanyInfoUseCase;
  final UserSessionRepository _userSessionRepository;

  UserSessionBloc(
    this._getCompanyInfoUseCase,
    this._userSessionRepository,
  ) : super(Initial());

  @override
  Stream<UserSessionState> mapEventToState(UserSessionEvent event) async* {
    if (event is CheckSession) {
      yield* _mapCheckSessionEventToState();
      return;
    }

    if (event is Logout) {
      yield* _mapLogoutEventToState();
      return;
    }

    return;
  }

  Stream<UserSessionState> _mapCheckSessionEventToState() async* {
    var output = await _getCompanyInfoUseCase.execute(null);
    if (output.isValid()) {
      yield ValidSession(output.userInfo);
    } else {
      yield InvalidSession();
    }
  }

  Stream<UserSessionState> _mapLogoutEventToState() async* {
    await _userSessionRepository.logout();
    yield InvalidSession();
  }
}
