import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Tile config', () {
    TileConfig createSubject({
      String id = 'id',
      String title = '',
      String deviceID = '',
      TileType tileType = TileType.text,
      TileData tileData = const TextTileData(
        prefix: '',
        postfix: '',
        jsonEnable: false,
        jsonExtraction: '',
      ),
    }) {
      return TileConfig(
        id: id,
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
          'id',
          '',
          '',
          TileType.text,
          const TextTileData(
            prefix: '',
            postfix: '',
            jsonEnable: false,
            jsonExtraction: '',
          ),
        ]);
      });
    });
    group('Placeholder tile config', () {
      test('create placeholder correctly', () {
        final empty = TileConfig.placeholder(tileType: TileType.text);
        expect(
          empty,
          TileConfig(
            id: empty.id,
            title: '',
            deviceID: '',
            tileType: TileType.text,
            tileData: TileData.placeholder(tileType: TileType.text),
          ),
        );
      });
    });
    group('from Json', () {
      test('works correctly', () {
        expect(
          TileConfig.fromJson(<String, dynamic>{
            'id': 'id',
            'title': '',
            'deviceID': '',
            'tileType': 'text',
            'tileData': {
              'type': 'text',
              'prefix': '',
              'postfix': '',
              'jsonEnable': false,
              'jsonExtraction': '',
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
            'id': 'id',
            'title': '',
            'deviceID': '',
            'tileType': 'text',
            'tileData': {
              'type': 'text',
              'prefix': '',
              'postfix': '',
              'jsonEnable': false,
              'jsonExtraction': '',
            },
          }),
        );
      });
    });
  });
}
