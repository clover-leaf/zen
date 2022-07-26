import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Project', () {
    Project createSubject({
      String id = 'id',
      String title = 'title',
      String brokerID = 'brokerID',
    }) {
      return Project(
        id: id,
        title: title,
        brokerID: brokerID,
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
          'brokerID',
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
            id: 'newID',
            title: 'newTitle',
            brokerID: 'newBrokerID',
          ),
          equals(
            createSubject(
              id: 'newID',
              title: 'newTitle',
            brokerID: 'newBrokerID',
            ),
          ),
        );
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        expect(
          Project.fromJson(<String, dynamic>{
            'id': 'id',
            'title': 'title',
            'brokerID': 'brokerID',
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
            'brokerID': 'brokerID',
          }),
        );
      });
    });
  });
}
