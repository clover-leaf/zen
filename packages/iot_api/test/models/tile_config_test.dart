import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('TileConfig', () {
    TileConfig createSubject({
      String id = 'id',
      String title = 'title',
      String deviceID = 'deviceID',
      TileType tileType = TileType.text,
      TileData tileData = const TextTileData(
        prefix: '',
        postfix: '',
        jsonVariableID: 'jsonVariableID',
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
          'deviceID',
          TileType.text,
          const TextTileData(
            prefix: '',
            postfix: '',
            jsonVariableID: 'jsonVariableID',
          ),
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
            title: 'newtitle',
            deviceID: 'newdeviceID',
            tileType: TileType.toggle,
            tileData: const TextTileData(
              prefix: 'prefix',
              postfix: 'postfix',
              jsonVariableID: 'jsonVariableID',
            ),
          ),
          equals(
            createSubject(
              id: 'newID',
              title: 'newtitle',
              deviceID: 'newdeviceID',
              tileType: TileType.toggle,
              tileData: const TextTileData(
                prefix: 'prefix',
                postfix: 'postfix',
                jsonVariableID: 'jsonVariableID',
              ),
            ),
          ),
        );
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        expect(
          TileConfig.fromJson(<String, dynamic>{
            'id': 'id',
            'title': 'title',
            'deviceID': 'deviceID',
            'tileType': 1,
            'tileData': {
              'prefix': '',
              'postfix': '',
              'jsonVariableID': 'jsonVariableID',
              'type': 1,
            },
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
            'deviceID': 'deviceID',
            'tileType': 1,
            'tileData': {
              'prefix': '',
              'postfix': '',
              'jsonVariableID': 'jsonVariableID',
              'type': 1,
            },
          }),
        );
      });
    });
  });
}
