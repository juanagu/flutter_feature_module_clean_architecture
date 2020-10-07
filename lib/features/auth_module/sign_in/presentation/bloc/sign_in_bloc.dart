import 'package:app/features/auth_module/sign_in/domain/use_cases/sign_in_input.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;

  SignInBloc(
    this.signInUseCase,
  ) : super(Uninitialized());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignIn) {
      yield* _mapToSignIn(event);
    }
  }

  Stream<SignInState> _mapToSignIn(SignIn signIn) async* {
    yield Authenticating();
    var input = SignInInput.fromCredential(signIn.username, signIn.password);
    try {
      var response = await signInUseCase.execute(input);
      if (response.isOk()) {
        yield Authenticated(response.user);
      } else if (response.isUnauthenticated()) {
        yield Unauthenticated();
      } else {
        yield ConnectionError();
      }
    } catch (e) {
      yield Failed(e);
    }
  }
}
