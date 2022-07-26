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
      String prefix = 'prefix',
      String postfix = 'postfix',
      String jsonVariableID = 'jsonVariableID',
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
        expect(createSubject(), equals(createSubject()));
      });
      test('props are correct', () {
        expect(createSubject().props, <dynamic>[
          'prefix',
          'postfix',
          'jsonVariableID',
        ]);
      });
    });
    group('placholder', () {
      test('works correctly', () {
        expect(TextTileData.placeholder, returnsNormally);
      });
      test('props are correct', () {
        expect(TextTileData.placeholder().props, <dynamic>[
          '',
          '',
          '',
        ]);
      });
    });
    group('copyWith', () {
      test('returns the same object if none arguments are provided', () {
        expect(createSubject().copyWith(), equals(createSubject()));
      });
      test('returns a new object with params provided', () {
        expect(
          createSubject().copyWith(
            prefix: 'newprefix',
            postfix: 'newpostfix',
            jsonVariableID: 'newjsonVariableID',
          ),
          equals(
            createSubject(
              prefix: 'newprefix',
              postfix: 'newpostfix',
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
            jsonVariableID: 'newjsonVariableID',
          );
          expect(
            subject.isFill(mockDevice),
            true,
          );
        });
        test('returns false when jsonVariableID is not filled', () {
          final subject = createSubject(
            jsonVariableID: '',
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
        test('returns true when jsonVariableID is not filled', () {
          final subject = createSubject(
            jsonVariableID: '',
          );
          expect(
            subject.isFill(mockDevice),
            true,
          );
        });
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        expect(
          TextTileData.fromJson(<String, dynamic>{
            'type': 1,
            'prefix': 'prefix',
            'postfix': 'postfix',
            'jsonVariableID': 'jsonVariableID',
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
            'type': 1,
            'prefix': 'prefix',
            'postfix': 'postfix',
            'jsonVariableID': 'jsonVariableID',
          }),
        );
      });
    });
  });
}
