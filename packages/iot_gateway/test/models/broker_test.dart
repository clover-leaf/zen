import 'package:iot_gateway/iot_gateway.dart';
import 'package:test/test.dart';

void main() {
  group('Broker', () {
    Broker createSubject({
      String url = 'url',
      int port = 1883,
      String? username,
      String? password,
    }) {
      return Broker(
        url: url,
        port: port,
        username: username,
        password: password,
      );
    }

    group('Constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });
      test('supports value equality', () {
        expect(createSubject(), equals(createSubject()));
      });
    });
    group('copyWith', () {
      test('returns same object if none arguments are provided', () {
        expect(createSubject().copyWith(), equals(createSubject()));
      });
      test('returns new object with params provided', () {
        expect(
          createSubject().copyWith(
            url: 'newUrl',
            username: 'username',
            password: 'password',
          ),
          equals(
            createSubject(
              url: 'newUrl',
              username: 'username',
              password: 'password',
            ),
          ),
        );
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        expect(
          Broker.fromJson(<String, dynamic>{
            'url': 'url',
            'port': 1883,
            'username': null,
            'password': null,
          }),
          equals(
            createSubject(),
          ),
        );
      });
    });
    group('toJson', () {
      test('works correctly', () {
        expect(
          createSubject().toJson(),
          equals(<String, dynamic>{
            'url': 'url',
            'port': 1883,
            'username': null,
            'password': null,
          }),
        );
      });
    });
  });
}
