import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';
import 'package:app/features/auth_module/sign_in/data/mappers/user_mapper.dart';
import 'package:test/test.dart';

void main() {
  group('user_mapper tests', () {
    test('map user to json', () {
      var user = UserLogged(
        'JAGU',
        'jagu@clarika.com.ar',
      );

      var json = UserMapper.toJson(user);

      expect(json['username'], user.username);
      expect(json['email'], user.email);
    });

    test('map null to json', () {
      var json = UserMapper.toJson(null);

      expect(json, null);
    });

    test('map json to user', () {
      var json = {
        'username': 'JAGU',
        'email': 'jagu@clarika.com.ar',
      };

      var user = UserMapper.fromJson(json);

      expect(user.username, 'JAGU');
      expect(user.email, 'jagu@clarika.com.ar');
    });

    test('map null to user', () {
      var user = UserMapper.fromJson(null);

      expect(user, null);
    });
  });
}
