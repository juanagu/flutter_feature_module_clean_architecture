import 'package:app/features/auth_module/core/domain/respositories/user_session_repository.dart';
import 'package:app/features/auth_module/user_session/domain/repositories/find_user_info_repository.dart';
import 'package:app/features/auth_module/user_session/domain/use_cases/get_user_info_output.dart';
import 'package:app/features/auth_module/user_session/domain/use_cases/get_user_info_input.dart';
import 'package:app/features/auth_module/user_session/domain/use_cases/get_user_info_use_case.dart';

class GetUserInfoUseCaseImpl implements GetUserInfoUseCase {
  final UserSessionRepository _userSessionRepository;
  final FindUserInfoRepository _getCompanyInfoRepository;

  GetUserInfoUseCaseImpl(
    this._userSessionRepository,
    this._getCompanyInfoRepository,
  );
  
  @override
  Future<GetUserInfoOutput> execute(GetUserInfoInput input) async {
    var userLogged = await _userSessionRepository.get();
    if (userLogged == null) {
      return GetUserInfoOutput.notUserLogged();
    }

    var company = await _getCompanyInfoRepository
        .byUsername(userLogged.username);

    return GetUserInfoOutput.byResult(company);
  }
}
