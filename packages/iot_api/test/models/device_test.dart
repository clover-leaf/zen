import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Device', () {
    Device createSubject({
      String id = 'id',
      String projectID = 'projectID',
      String topic = 'topic',
      String title = 'title',
      bool jsonEnable = false,
      List<JsonVariable> jsonVariables = const [],
    }) {
      return Device(
        id: id,
        projectID: projectID,
        topic: topic,
        title: title,
        jsonEnable: jsonEnable,
        jsonVariables: jsonVariables,
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
          'projectID',
          'topic',
          'title',
          false,
          <JsonVariable>[],
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
            projectID: 'newprojectID',
            topic: 'newtopic',
            title: 'newTitle',
            jsonEnable: true,
            jsonVariables: [],
          ),
          equals(
            createSubject(
              id: 'newID',
              projectID: 'newprojectID',
              topic: 'newtopic',
              title: 'newTitle',
              jsonEnable: true,
              jsonVariables: [],
            ),
          ),
        );
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        expect(
          Device.fromJson(<String, dynamic>{
            'id': 'id',
            'projectID': 'projectID',
            'topic': 'topic',
            'title': 'title',
            'jsonEnable': false,
            'jsonVariables': <JsonVariable>[],
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
            'projectID': 'projectID',
            'topic': 'topic',
            'title': 'title',
            'jsonEnable': false,
            'jsonVariables': <JsonVariable>[],
          }),
        );
      });
    });
  });
}
