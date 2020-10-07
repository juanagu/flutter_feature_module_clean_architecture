import 'package:app/features/auth_module/user_session/domain/use_cases/get_user_info_input.dart';
import 'package:app/features/auth_module/user_session/domain/use_cases/get_user_info_output.dart';

abstract class GetUserInfoUseCase {
  Future<GetUserInfoOutput> execute(GetUserInfoInput input);
}
