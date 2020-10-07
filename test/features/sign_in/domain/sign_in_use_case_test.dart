import 'package:app/features/auth_module/core/domain/entities/user_session.dart';
import 'package:app/features/auth_module/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/implementation/sign_in_imp_use_case.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/sign_in_input.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class SignInMockRepository extends Mock implements SignInRepository {}

class UserSessionMock extends Mock implements UserSession {}

void main() {
  group('sign in use case', () {
    test('with valid credentials', () async {
      var signInInput =
          SignInInput.fromCredential('validUsername', 'validPassword');

      final signInRepository = SignInMockRepository();
      when(signInRepository.authorize(signInInput.credential))
          .thenAnswer((_) => Future.value(UserAuth(
                'token',
                'full name user',
                'ASDASDADASD',
              )));

      final userSession = UserSessionMock();
      when(userSession.create(argThat(isNotNull)))
          .thenAnswer((_) => Future.value(true));

      SignInUseCase usecase = SignInImpUseCase(signInRepository, userSession);
      var func = await usecase.execute(signInInput);
      expect(func.isOk(), true);
    });

    test('with valid empty credentials', () async {
      var signInInput = SignInInput.fromCredential('', '');

      final signInRepository = SignInMockRepository();
      final userSession = UserSessionMock();
      when(userSession.create(argThat(isNotNull)))
          .thenAnswer((_) => Future.value(true));

      SignInUseCase usecase = SignInImpUseCase(signInRepository, userSession);
      var func = await usecase.execute(signInInput);
      expect(func.isOk(), false);
    });

    test('with invalid credentials', () async {
      var signInInput =
          SignInInput.fromCredential('validUsername', 'validPassword');

      final signInRepository = SignInMockRepository();
      when(signInRepository.authorize(signInInput.credential))
          .thenAnswer((_) => Future.value(null));

      final userSession = UserSessionMock();
      when(userSession.create(argThat(isNotNull)))
          .thenAnswer((_) => Future.value(true));

      SignInUseCase usecase = SignInImpUseCase(signInRepository, userSession);
      var func = await usecase.execute(signInInput);
      expect(func.isOk(), false);
    });
  });
}
