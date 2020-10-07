import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/infrastructure/libraries/helpers/dio_http_helper.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class OAuthHelperMock extends Mock implements OAuthHelper {}

void main() {
  test('test DioHttpHelper get', () async {
    var httpHelper = DioHttpHelper(OAuthHelperMock());

    var response = await httpHelper.get(
        'https://my-json-server.typicode.com/juanagu/mobile-interview/users');

    expect(response != null, true,
        reason: 'expect a response different than null');
  });

  test('test DioHttpHelper post', () async {
    var httpHelper = DioHttpHelper(OAuthHelperMock());

    var response = await httpHelper.post(
      'https://soa-desa-iis.imperial.cl/RsCazadora/RsAppCazadora.svc/Authenticate',
      data: {'username': 'F014', 'credential': '123456789'},
    );

    expect(response.statusCode, 200,
        reason: 'Expect a success response with statusCode == 200');
  });
}
