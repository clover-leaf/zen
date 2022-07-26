import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('JsonVariable', () {
    JsonVariable createSubject({
      String id = 'id',
      String deviceID = 'deviceID',
      String title = 'title',
      String jsonExtraction = 'jsonExtraction',
    }) {
      return JsonVariable(
        id: id,
        deviceID: deviceID,
        title: title,
        jsonExtraction: jsonExtraction,
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
          'deviceID',
          'title',
          'jsonExtraction',
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
            deviceID: 'newdeviceID',
            title: 'newTitle',
            jsonExtraction: 'newjsonExtraction',
          ),
          equals(
            createSubject(
              id: 'newID',
              deviceID: 'newdeviceID',
              title: 'newTitle',
              jsonExtraction: 'newjsonExtraction',
            ),
          ),
        );
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        expect(
          JsonVariable.fromJson(<String, dynamic>{
            'id': 'id',
            'deviceID': 'deviceID',
            'title': 'title',
            'jsonExtraction': 'jsonExtraction',
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
            'deviceID': 'deviceID',
            'title': 'title',
            'jsonExtraction': 'jsonExtraction',
          }),
        );
      });
    });
  });
}
