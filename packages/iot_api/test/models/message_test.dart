import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Message', () {
    Message createSubject({
      int id = 0,
      String title = 'title',
      DateTime? createAt,
      bool isReaded = true,
      AlertLevel alertLevel = AlertLevel.normal,
      String description = 'description',
    }) {
      return Message(
        id: id,
        title: title,
        alertLevel: alertLevel,
        isReaded: isReaded,
        createAt: createAt ?? DateTime(2022, 6, 10),
        description: description,
      );
    }

    group('constructor', () {
      test('work correctly', () {
        expect(createSubject, returnsNormally);
      });
      test('supports value equality', () {
        expect(createSubject(), equals(createSubject()));
      });
      test('props are correct', () {
        expect(createSubject().props, <dynamic>[
          0,
          'title',
          AlertLevel.normal,
          true,
          DateTime(2022, 6, 10),
          'description',
        ]);
      });
    });

    group('from Json', () {
      test('works correctly', () {
        expect(
          Message.fromJson(<String, dynamic>{
            'id': 0,
            'title': 'title',
            'alertLevel': 1,
            'isReaded': true,
            'createAt': DateTime(2022, 6, 10).toIso8601String(),
            'description': 'description',
          }),
          equals(
            createSubject(),
          ),
        );
      });
    });
    group('to Json', () {
      test('works correctly', () {
        expect(
          createSubject().toJson(),
          equals(<String, dynamic>{'id': 0,
            'title': 'title',
            'alertLevel': 1,
            'isReaded': true,
            'createAt': DateTime(2022, 6, 10).toIso8601String(),
            'description': 'description',
          }),
        );
      });
    });
  });
}
