import 'sign_in_input.dart';
import 'sign_in_output.dart';

abstract class SignInUseCase {
  Future<SignInOutput> execute(SignInInput input);
}
