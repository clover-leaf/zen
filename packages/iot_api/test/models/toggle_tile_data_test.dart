import 'package:iot_api/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Toggle tile data', () {
    ToggleTileData createSubject({
      String onLabel = 'onLabel',
      String onValue = 'onValue',
      String offLabel = 'offLabel',
      String offValue = 'offValue',
      bool jsonEnable = false,
      String jsonExtraction = r'$["key"]',
    }) {
      return ToggleTileData(
        onLabel: onLabel,
        onValue: onValue,
        offLabel: offLabel,
        offValue: offValue,
        jsonEnable: jsonEnable,
        jsonExtraction: jsonExtraction,
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
          'onLabel',
          'onValue',
          'offLabel',
          'offValue',
          false,
          r'$["key"]',
        ]);
      });
      test('placeholder working properly', () {
        expect(ToggleTileData.placeholder().props, <dynamic>[
          'ON',
          '1',
          'OFF',
          '0',
          false,
          '',
        ]);
      });
    });

    group('is fill', () {
      test('works correctly when filled', () {
        expect(
          ToggleTileData.fromJson(<String, dynamic>{
            'type': 'toggle',
            'onLabel': 'onLabel',
            'onValue': 'onValue',
            'offLabel': 'offLabel',
            'offValue': 'offValue',
            'jsonEnable': false,
            'jsonExtraction': r'$["key"]',
          }).isFill(),
          true,
        );
      });
      test('works correctly when onValue not filled', () {
        expect(
          ToggleTileData.fromJson(<String, dynamic>{
            'type': 'toggle',
            'onLabel': 'onLabel',
            'onValue': '',
            'offLabel': 'offLabel',
            'offValue': 'offValue',
            'jsonEnable': false,
            'jsonExtraction': r'$["key"]',
          }).isFill(),
          false,
        );
      });
      test('works correctly when offValue not filled', () {
        expect(
          ToggleTileData.fromJson(<String, dynamic>{
            'type': 'toggle',
            'onLabel': 'onLabel',
            'onValue': 'onValue',
            'offLabel': 'offLabel',
            'offValue': '',
            'jsonEnable': false,
            'jsonExtraction': r'$["key"]',
          }).isFill(),
          false,
        );
      });
    });
    group('from Json', () {
      test('works correctly', () {
        expect(
          ToggleTileData.fromJson(<String, dynamic>{
            'type': 'toggle',
            'onLabel': 'onLabel',
            'onValue': 'onValue',
            'offLabel': 'offLabel',
            'offValue': 'offValue',
            'jsonEnable': false,
            'jsonExtraction': r'$["key"]',
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
            'type': 'toggle',
            'onLabel': 'onLabel',
            'onValue': 'onValue',
            'offLabel': 'offLabel',
            'offValue': 'offValue',
            'jsonEnable': false,
            'jsonExtraction': r'$["key"]',
          }),
        );
      });
    });
  });
}
