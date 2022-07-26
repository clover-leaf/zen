import 'package:iot_api/src/models/models.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDevice extends Mock implements Device {}

void main() {
  group('ToggleTileData', () {
    late MockDevice mockDevice;
    setUp(() {
      mockDevice = MockDevice();
      when(() => mockDevice.jsonEnable).thenReturn(true);
    });
    ToggleTileData createSubject({
      String onLabel = 'onLabel',
      String onValue = 'onValue',
      String offLabel = 'offLabel',
      String offValue = 'offValue',
      String jsonVariableID = 'jsonVariableID',
    }) {
      return ToggleTileData(
        onLabel: onLabel,
        onValue: onValue,
        offLabel: offLabel,
        offValue: offValue,
        jsonVariableID: jsonVariableID,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });
      test('supports value equality', () {
        expect(createSubject(), equals(createSubject()));
      });
      test('props are correct', () {
        expect(createSubject().props, <dynamic>[
          'onLabel',
          'onValue',
          'offLabel',
          'offValue',
          'jsonVariableID',
        ]);
      });
    });
    group('placholder', () {
      test('works correctly', () {
        expect(ToggleTileData.placeholder, returnsNormally);
      });
      test('props are correct', () {
        expect(
          ToggleTileData.placeholder().props,
          <dynamic>['ON', '1', 'OFF', '0', ''],
        );
      });
    });
    group('copyWith', () {
      test('returns the same object if none arguments are provided', () {
        expect(createSubject().copyWith(), equals(createSubject()));
      });
      test('returns a new object with params provided', () {
        expect(
          createSubject().copyWith(
            onLabel: 'newonLabel',
            onValue: 'newonValue',
            offLabel: 'newoffLabel',
            offValue: 'newoffValue',
            jsonVariableID: 'newjsonVariableID',
          ),
          equals(
            createSubject(
              onLabel: 'newonLabel',
              onValue: 'newonValue',
              offLabel: 'newoffLabel',
              offValue: 'newoffValue',
              jsonVariableID: 'newjsonVariableID',
            ),
          ),
        );
      });
    });
    group('isFill', () {
      group('json extraction is enabled', () {
        test('returns true when every needed field are filled', () {
          final subject = createSubject(
            onValue: 'newonValue',
            offValue: 'newoffValue',
            jsonVariableID: 'newjsonVariableID',
          );
          expect(
            subject.isFill(mockDevice),
            true,
          );
        });
        test('returns false when onValue is not filled', () {
          final subject = createSubject(
            onValue: '',
            jsonVariableID: 'newjsonVariableID',
          );
          expect(
            subject.isFill(mockDevice),
            false,
          );
        });
        test('returns false when offValue is not filled', () {
          final subject = createSubject(
            offValue: '',
            jsonVariableID: 'newjsonVariableID',
          );
          expect(
            subject.isFill(mockDevice),
            false,
          );
        });
      });
      group('json extraction is disabled', () {
        setUp(() {
          when(() => mockDevice.jsonEnable).thenReturn(false);
        });
        test('returns true when every needed field are filled', () {
          final subject = createSubject(
            onValue: 'newonValue',
            offValue: 'newoffValue',
            jsonVariableID: '',
          );
          expect(
            subject.isFill(mockDevice),
            true,
          );
        });
        test('returns false when onValue is not filled', () {
          final subject = createSubject(
            onValue: '',
            jsonVariableID: '',
          );
          expect(
            subject.isFill(mockDevice),
            false,
          );
        });
        test('returns false when offValue is not filled', () {
          final subject = createSubject(
            offValue: '',
            jsonVariableID: '',
          );
          expect(
            subject.isFill(mockDevice),
            false,
          );
        });
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        expect(
          ToggleTileData.fromJson(<String, dynamic>{
            'type': 0,
            'onLabel': 'onLabel',
            'onValue': 'onValue',
            'offLabel': 'offLabel',
            'offValue': 'offValue',
            'jsonVariableID': 'jsonVariableID',
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
            'type': 0,
            'onLabel': 'onLabel',
            'onValue': 'onValue',
            'offLabel': 'offLabel',
            'offValue': 'offValue',
            'jsonVariableID': 'jsonVariableID',
          }),
        );
      });
    });
  });
}
