import 'package:app/commons/helpers/http_helper.dart';
import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/features/auth_module/sign_in/data/remote/sign_in_input_dto.dart';
import 'package:app/features/auth_module/sign_in/data/remote/sign_in_remote_repository.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_credential.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpHelperMock extends Mock implements HttpHelper {}

class OAuthHelperMock extends Mock implements OAuthHelper {}

void main() {
  group('sign in repository', () {
    final username = 'myUsername';
    final password = 'myPassword';
    final baseUrl = 'http://base.url/';
    final userCredential = UserCredential(username, password);
    final json = SignInInputDto.fromUserCredential(userCredential).toJson();
    test('send valid credentials and get successfully response', () async {
      var httpHelper = HttpHelperMock();
      var oAuthHelper = OAuthHelperMock();
      var repository = SignInRemoteRepository(
        baseUrl,
        httpHelper,
        oAuthHelper,
      );
      var url = repository.getSignInUrl();

      var httpResponse = HttpResponse({
        'username': '23285703379',
        'email': '23285703379@valeengine.com',
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiMjMyODU3MDMzNzkiLCJqdGkiOiJiYTIxN2RiZC1mYjg4LTQ5MzMtODIwMC1iYjQ3MDFiZTdjMTMiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJDb21wYW55IiwiZXhwIjoxNTk2MDU3ODc1LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU0MTY5IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1NDE2OSJ9.1f4pwnhfe8-Vd8ponIDJO8ubB4WsixMvhWUYpgKBh3k',
        'expiration_time': '2020-07-29T21:24:35Z'
      }, 200);

      when(httpHelper.post(url, data: json))
          .thenAnswer((_) => Future.value(httpResponse));

      var result = await repository.authorize(userCredential);
      expect(result.isValid(), true);
    });

    test('send credentials and get unauthorized response', () async {
      var httpHelper = HttpHelperMock();
      var oAuthHelper = OAuthHelperMock();
      var repository = SignInRemoteRepository(
        baseUrl,
        httpHelper,
        oAuthHelper,
      );
      var url = repository.getSignInUrl();

      var httpResponse = HttpResponse({
        'data': 'username or password are invalid',
      }, 401);

      when(httpHelper.post(url, data: json))
          .thenAnswer((_) => Future.value(httpResponse));

      var result = await repository.authorize(userCredential);
      expect(result, null);
    });

    test('send credentials and internal server error', () async {
      var httpHelper = HttpHelperMock();
      var oAuthHelper = OAuthHelperMock();
      var repository = SignInRemoteRepository(baseUrl, httpHelper, oAuthHelper);
      var url = repository.getSignInUrl();

      var httpResponse = HttpResponse(null, 500);

      when(httpHelper.post(url, data: json))
          .thenAnswer((_) => Future.value(httpResponse));

      var result = await repository.authorize(userCredential);
      expect(result, null);
    });
  });
}
