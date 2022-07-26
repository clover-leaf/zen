import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('TileType', () {
    group('toTitle', () {
      test('toggle', () {
        expect(TileType.toggle.toTitle(), equals('Toggle'));
      });
      test('text', () {
        expect(TileType.text.toTitle(), equals('Text'));
      });
    });
    group('toJsonKey', () {
      test('toggle', () {
        expect(TileType.toggle.toJsonKey(), equals(0));
      });
      test('text', () {
        expect(TileType.text.toJsonKey(), equals(1));
      });
    });
    group('fromJsonKey', () {
      test('toggle', () {
        expect(TileTypeX.fromJsonKey(0), equals(TileType.toggle));
      });
      test('text', () {
        expect(TileTypeX.fromJsonKey(1), equals(TileType.text));
      });
    });
  });
}
