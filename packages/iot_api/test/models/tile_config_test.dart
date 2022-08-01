import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('TileConfig', () {
    TileConfig createSubject({
      FieldId? id,
      String name = 'name',
      FieldId deviceID = 'device_id',
      TileType tileType = TileType.text,
      TileData tileData = const TextTileData(
        prefix: null,
        postfix: null,
        jsonVariableID: null,
      ),
    }) {
      return TileConfig(
        id: id,
        name: name,
        deviceID: deviceID,
        tileType: tileType,
        tileData: tileData,
      );
    }

    group('Constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });
      test('supports value equality', () {
        final subjectA = createSubject();
        final subjectB = createSubject(id: subjectA.id);
        expect(subjectA, subjectB);
      });
      test('props are correct', () {
        final props = <dynamic>[
          anything,
          'name',
          'device_id',
          TileType.text,
          const TextTileData(
            prefix: null,
            postfix: null,
            jsonVariableID: null,
          )
        ];
        expect(createSubject().props, props);
      });
    });
    group('copyWith', () {
      test('returns same object if none arguments are provided', () {
        final subjectA = createSubject();
        final subjectB = subjectA.copyWith();
        expect(subjectA, subjectB);
      });
      test('returns new object with params provided', () {
        final subjectA = createSubject(
          name: 'newname',
        );
        final subjectB = createSubject().copyWith(
          id: subjectA.id,
          name: 'newname',
        );
        expect(subjectA, subjectB);
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        final subject = createSubject();
        final json = <String, dynamic>{
          'id': subject.id,
          'name': 'name',
          'device_id': 'device_id',
          'tile_type': 1,
          'tile_data': {
            'prefix': null,
            'postfix': null,
            'json_variable_id': null,
            'tile_type': 1,
          },
        };
        expect(subject, TileConfig.fromJson(json));
      });
    });
    group('toJson', () {
      test('works correctly', () {
        final subject = createSubject();
        final json = <String, dynamic>{
          'id': subject.id,
          'name': 'name',
          'device_id': 'device_id',
          'tile_type': 1,
          'tile_data': {
            'prefix': null,
            'postfix': null,
            'json_variable_id': null,
            'tile_type': 1,
          },
        };
        expect(subject.toJson(), json);
      });
    });
  });
}
