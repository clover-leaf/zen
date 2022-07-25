import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Tile data', () {
    TileData createSubject({
      required JsonMap json,
    }) {
      return TileData.fromJson(json);
    }

    group('Placeholder tile data', () {
      test('create placeholder with given TileType', () {
        expect(
          TileData.placeholder(tileType: TileType.text),
          const TextTileData(
            prefix: '',
            postfix: '',
            jsonEnable: false,
            jsonExtraction: '',
          ),
        );
      });
    });
    group('from Json', () {
      test('works correctly with TextTileData', () {
        final json = <String, dynamic>{
          'type': 'text',
          'prefix': 'prefix',
          'postfix': 'postfix',
          'jsonEnable': false,
          'jsonExtraction': 'jsonExtraction',
        };
        expect(createSubject(json: json), TextTileData.fromJson(json));
      });
      test('works correctly with ToggleTileData', () {
        final json = <String, dynamic>{
          'type': 'toggle',
          'onLabel': 'onLabel',
          'onValue': 'onValue',
          'offLabel': 'offLabel',
          'offValue': 'offValue',
          'jsonEnable': false,
          'jsonExtraction': 'jsonExtraction',
        };
        expect(createSubject(json: json), ToggleTileData.fromJson(json));
      });
    });
    group('to Json', () {
      test('works correctly with TextTileData', () {
        final json = <String, dynamic>{
          'type': 'text',
          'prefix': 'prefix',
          'postfix': 'postfix',
          'jsonEnable': false,
          'jsonExtraction': 'jsonExtraction',
        };
        expect(
          createSubject(json: json).toJson(),
          equals(json),
        );
      });
      test('works correctly with ToggleTileData', () {
        final json = <String, dynamic>{
          'type': 'toggle',
          'onLabel': 'onLabel',
          'onValue': 'onValue',
          'offLabel': 'offLabel',
          'offValue': 'offValue',
          'jsonEnable': false,
          'jsonExtraction': 'jsonExtraction',
        };
        expect(
          createSubject(json: json).toJson(),
          equals(json),
        );
      });
    });
  });
}
