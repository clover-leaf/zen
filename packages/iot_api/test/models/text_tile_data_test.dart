import 'package:iot_api/iot_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDevice extends Mock implements Device {}

void main() {
  group('TextTileData', () {
    late MockDevice mockDevice;
    setUp(() {
      mockDevice = MockDevice();
      when(() => mockDevice.jsonEnable).thenReturn(true);
    });
    TextTileData createSubject({
      String? prefix,
      String? postfix,
      FieldId? jsonVariableID,
    }) {
      return TextTileData(
        prefix: prefix,
        postfix: postfix,
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
        final props = <dynamic>[
          null,
          null,
          null,
        ];
        final subject = createSubject();
        expect(subject.props, props);
      });
    });
    group('placholder', () {
      test('works correctly', () {
        expect(TextTileData.placeholder, returnsNormally);
      });
      test('props are correct', () {
        expect(TextTileData.placeholder().props, <dynamic>[
          null,
          null,
          null,
        ]);
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
          prefix: 'newprefix',
          postfix: 'newpostfix',
          jsonVariableID: 'id',
        );
        final subjectB = createSubject(
          prefix: 'newprefix',
          postfix: 'newpostfix',
          jsonVariableID: 'id',
        );
        expect(subjectA, subjectB);
      });
    });
    group('isFilled', () {
      group('json extraction is enabled', () {
        test('returns true when every needed field are filled', () {
          final subject = createSubject(
            jsonVariableID: 'id',
          );
          expect(
            subject.isFilled(mockDevice),
            true,
          );
        });
        test('returns false when jsonVariableID is not filled', () {
          final subject = createSubject();
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
        test('returns true when jsonVariableID is not filled', () {
          final subject = createSubject(
            jsonVariableID: 'id',
          );
          expect(
            subject.isFilled(mockDevice),
            true,
          );
        });
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        final json = <String, dynamic>{
          'tile_type': 1,
          'prefix': null,
          'postfix': null,
          'json_variable_id': null,
        };
        final subject = createSubject();
        expect(subject, TextTileData.fromJson(json));
      });
    });
    group('toJson', () {
      test('works correctly', () {
        final json = <String, dynamic>{
          'tile_type': 1,
          'prefix': null,
          'postfix': null,
          'json_variable_id': null,
        };
        final subject = createSubject();
        expect(subject.toJson(), json);
      });
    });
  });
}
