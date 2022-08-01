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
      String? onLabel,
      String? onValue,
      String? offLabel,
      String? offValue,
      FieldId? jsonVariableID,
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
        final subjectA = createSubject();
        final subjectB = createSubject();
        expect(subjectA, subjectB);
      });
      test('props are correct', () {
        expect(createSubject().props, <dynamic>[
          null,
          null,
          null,
          null,
          null,
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
          <dynamic>[null, null, null, null, null],
        );
      });
    });
    group('copyWith', () {
      test('returns the same object if none arguments are provided', () {
        final subjectA = createSubject();
        final subjectB = subjectA.copyWith();
        expect(subjectA, subjectB);
      });
      test('returns a new object with params provided', () {
        final subjectA = createSubject().copyWith(
          onLabel: 'newonLabel',
          onValue: 'newonValue',
          offLabel: 'newoffLabel',
          offValue: 'newoffValue',
          jsonVariableID: 'id',
        );
        final subjectB = createSubject(
          onLabel: 'newonLabel',
          onValue: 'newonValue',
          offLabel: 'newoffLabel',
          offValue: 'newoffValue',
          jsonVariableID: 'id',
        );
        expect(subjectA, subjectB);
      });
    });
    group('isFilled', () {
      group('json extraction is enabled', () {
        test('returns true when every needed field are filled', () {
          final subject = createSubject(
            onValue: 'newonValue',
            offValue: 'newoffValue',
            jsonVariableID: 'id',
          );
          expect(subject.isFilled(mockDevice), true);
        });
        test('returns false when onValue is not filled', () {
          final subject = createSubject(
            onValue: '',
            offValue: '0',
            jsonVariableID: 'id',
          );
          expect(subject.isFilled(mockDevice), false);
        });
        test('returns false when offValue is not filled', () {
          final subject = createSubject(
            onValue: '1',
            offValue: '',
            jsonVariableID: 'id',
          );
          expect(
            subject.isFilled(mockDevice),
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
            jsonVariableID: 'id',
          );
          expect(
            subject.isFilled(mockDevice),
            true,
          );
        });
        test('returns false when onValue is not filled', () {
          final subject = createSubject(
            jsonVariableID: 'id',
          );
          expect(
            subject.isFilled(mockDevice),
            false,
          );
        });
        test('returns false when offValue is not filled', () {
          final subject = createSubject(
            offValue: '',
            jsonVariableID: 'id',
          );
          expect(
            subject.isFilled(mockDevice),
            false,
          );
        });
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        final json = <String, dynamic>{
          'tile_type': 0,
          'on_label': null,
          'on_value': null,
          'off_label': null,
          'off_value': null,
          'json_variable_id': null,
        };
        final subject = createSubject();
        expect(subject, ToggleTileData.fromJson(json));
      });
    });
    group('to Json', () {
      test('works correctly', () {
        final json = <String, dynamic>{
          'tile_type': 0,
          'on_label': null,
          'on_value': null,
          'off_label': null,
          'off_value': null,
          'json_variable_id': null,
        };
        final subject = createSubject();
        expect(subject.toJson(), json);
      });
    });
  });
}
