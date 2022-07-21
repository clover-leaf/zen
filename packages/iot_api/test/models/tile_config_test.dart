import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Tile config', () {
    TileConfig createSubject({
      String title = 'title',
      String deviceID = 'deviceID',
      TileType tileType = TileType.text,
      TileData tileData = const TextTileData(),
    }) {
      return TileConfig(
        title: title,
        deviceID: deviceID,
        tileType: tileType,
        tileData: tileData,
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
          'title',
          'deviceID',
          TileType.text,
          const TextTileData(),
        ]);
      });
    });

    group('from Json', () {
      test('works correctly', () {
        expect(
          TileConfig.fromJson(<String, dynamic>{
            'title': 'title',
            'deviceID': 'deviceID',
            'tileType': 'text',
            'tileData': {
              'type': 'text',
              'prefix': null,
              'postfix': null,
              'jsonExtraction': null,
            },
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
            'title': 'title',
            'deviceID': 'deviceID',
            'tileType': 'text',
            'tileData': {
              'type': 'text',
              'prefix': null,
              'postfix': null,
              'jsonExtraction': null,
            },
          }),
        );
      });
    });
  });
}
