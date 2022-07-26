import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('TileData', () {
    group('placeholder', () {
      test('Creates TextTileData.placeholder with TileType.text', () {
        expect(
          TileData.placeholder(tileType: TileType.text),
          equals(
            TextTileData.placeholder(),
          ),
        );
      });
      test('creates placeholder with TileType.toggle', () {
        expect(
          TileData.placeholder(tileType: TileType.toggle),
          equals(
            ToggleTileData.placeholder(),
          ),
        );
      });
    });
    group('fromJson', () {
      test('works correctly with ToggleTileData', () {
        final json = <String, dynamic>{
          'type': 0,
          'onLabel': 'onLabel',
          'onValue': 'onValue',
          'offLabel': 'offLabel',
          'offValue': 'offValue',
          'jsonVariableID': 'jsonVariableID',
        };
        expect(TileData.fromJson(json), ToggleTileData.fromJson(json));
      });
      test('works correctly with TextTileData', () {
        final json = <String, dynamic>{
          'type': 1,
          'prefix': 'prefix',
          'postfix': 'postfix',
          'jsonVariableID': 'jsonVariableID',
        };
        expect(TileData.fromJson(json), TextTileData.fromJson(json));
      });
    });
    group('toJson', () {
      test('works correctly with ToggleTileData', () {
        final json = <String, dynamic>{
          'type': 0,
          'onLabel': 'onLabel',
          'onValue': 'onValue',
          'offLabel': 'offLabel',
          'offValue': 'offValue',
          'jsonVariableID': 'jsonVariableID',
        };
        expect(
          TileData.fromJson(json).toJson(),
          equals(json),
        );
      });
      test('works correctly with TextTileData', () {
        final json = <String, dynamic>{
          'type': 1,
          'prefix': 'prefix',
          'postfix': 'postfix',
          'jsonVariableID': 'jsonVariableID',
        };
        expect(
          TileData.fromJson(json).toJson(),
          equals(json),
        );
      });
    });
  });
}
