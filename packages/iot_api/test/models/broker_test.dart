import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Broker', () {
    Broker createSubject({
      String id = 'id',
      String title = 'title',
      String url = 'url',
      int port = 1883,
      String? username,
      String? password,
    }) {
      return Broker(
        id: id,
        title: title,
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
      test('props are correct', () {
        expect(createSubject().props, <dynamic>[
          'id',
          'title',
          'url',
          1883,
          null,
          null,
        ]);
      });
    });
    group('copyWith', () {
      test('returns same object if none arguments are provided', () {
        expect(createSubject().copyWith(), equals(createSubject()));
      });
      test('returns new object with params provided', () {
        expect(
          createSubject().copyWith(
            id: 'newID',
            title: 'newTitle',
            url: 'newUrl',
            username: 'username',
            password: 'password',
          ),
          equals(
            createSubject(
              id: 'newID',
              title: 'newTitle',
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
            'id': 'id',
            'title': 'title',
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
            'id': 'id',
            'title': 'title',
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
