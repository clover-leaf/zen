import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Text tile data', () {
    TextTileData createSubject({
      String prefix = 'prefix',
      String postfix = 'postfix',
      bool jsonEnable = false,
      String jsonExtraction = r'$["key"]',
    }) {
      return TextTileData(
        prefix: prefix,
        postfix: postfix,
        jsonEnable: jsonEnable,
        jsonExtraction: jsonExtraction,
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
          'prefix',
          'postfix',
          false,
          r'$["key"]',
        ]);
      });
    });

    group('from Json', () {
      test('works correctly', () {
        expect(
          TextTileData.fromJson(<String, dynamic>{
            'type': 'text',
            'prefix': 'prefix',
            'postfix': 'postfix',
            'jsonEnable': false,
            'jsonExtraction': r'$["key"]',
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
          equals(<String, dynamic>{
            'type': 'text',
            'prefix': 'prefix',
            'postfix': 'postfix',
            'jsonEnable': false,
            'jsonExtraction': r'$["key"]',
          }),
        );
      });
    });
  });
}
