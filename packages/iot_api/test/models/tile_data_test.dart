import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Tile data', () {
    TileData createSubject({
      required JsonMap json,
    }) {
      return TileData.fromJson(json);
    }
    group('from Json', () {
      test('works correctly with TextTileData', () {
        final json = <String, dynamic>{
          'type': 'text',
          'prefix': 'prefix',
          'postfix': 'postfix',
          'jsonExtraction': 'jsonExtraction',
        };
        expect(TileData.fromJson(json), TextTileData.fromJson(json));
      });
    });
    group('to Json', () {
      test('works correctly', () {
        final json = <String, dynamic>{
          'type': 'text',
          'prefix': 'prefix',
          'postfix': 'postfix',
          'jsonExtraction': 'jsonExtraction',
        };
        expect(
          createSubject(json: json).toJson(),
          equals(json),
        );
      });
    });
  });
  group('Text block data', () {
    TextTileData createSubject({
      String prefix = 'prefix',
      String postfix = 'postfix',
      String jsonExtraction = r'$["key"]',
    }) {
      return TextTileData(
        prefix: prefix,
        postfix: postfix,
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
            'jsonExtraction': r'$["key"]',
          }),
        );
      });
    });
  });
}
