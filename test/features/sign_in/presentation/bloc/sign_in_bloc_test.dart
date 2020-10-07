import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/sign_in_notification.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/sign_in_output.dart';
import 'package:app/features/auth_module/sign_in/presentation/bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/sign_in_use_case.dart';

class SignInUseCaseMock extends Mock implements SignInUseCase {}

class SignInOutputMock extends Mock implements SignInOutput {}

void main() {
  SignInUseCaseMock signInUseCaseMock;

  setUp(() {
    signInUseCaseMock = SignInUseCaseMock();
  });

  group('sign in bloc test', () {
    final user = UserLogged('name', 'jagu@clarika.com.ar');
    final response = SignInOutput(user, SignInNotification());
    final signIn = SignIn('name', 'password');

    blocTest('emits [Authenticating, Authenticated] success',
        build: () {
          when(signInUseCaseMock.execute(any))
              .thenAnswer((_) => Future.value(response));
          return SignInBloc(signInUseCaseMock);
        },
        act: (bloc) => bloc..add(signIn),
        expect: [
          Authenticating(),
          Authenticated(response.user),
        ]);

    blocTest(
        'emits [Authenticating, Unauthenticated] success but not authenticated',
        build: () {
          final responseUserNotAuthenticated = SignInOutput(
            null,
            SignInNotification().addError(
              SignInError(SignInErrorType.InvalidCredentials, ''),
            ),
          );
          when(signInUseCaseMock.execute(any))
              .thenAnswer((_) => Future.value(responseUserNotAuthenticated));
          return SignInBloc(signInUseCaseMock);
        },
        act: (bloc) => bloc..add(signIn),
        expect: [
          Authenticating(),
          Unauthenticated(),
        ]);

    final e = Exception();
    blocTest('emits [Authenticating, Failed] failed',
        build: () {
          var response = SignInOutputMock();
          when(signInUseCaseMock.execute(any))
              .thenAnswer((_) => Future.value(response));
          when(response.isOk()).thenThrow(e);
          return SignInBloc(signInUseCaseMock);
        },
        act: (bloc) => bloc..add(signIn),
        expect: [
          Authenticating(),
          Failed(e),
        ]);
  });
}
