// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockIotApi extends Mock implements IotApi {}

void main() {
  late MockIotApi api;
  final initDevices = [
    Device(
      id: 4,
      deviceName: 'Air sensor XII',
      parentId: 1,
      status: Status.running,
      deviceType: 1,
      serialNumber: '1asda',
      createAt: DateTime.parse('2022-06-10T21:05:06.000Z'),
      createBy: 1,
      startDate: DateTime.parse('2022-06-10T21:05:06.000Z'),
      endDate: DateTime.parse('2022-06-21T21:05:06.000Z'),
      deleteAt: DateTime.parse('2022-06-22T21:05:06.000Z'),
      deleteBy: 1,
      updateAt: DateTime.parse('2022-06-13T21:05:06.000Z'),
      updateBy: 1,
      description: 'Air sensor XII description',
    ),
  ];

  setUp(() {
    api = MockIotApi();
    when(
      () => api.fetchDevices(
        startIndex: any(named: 'startIndex'),
        count: any(named: 'count'),
      ),
    ).thenAnswer((_) async => initDevices);
    when(() => api.fetchLiveData()).thenAnswer(
      (invocation) => Stream.fromIterable([1, 2, 3, 4]),
    );
  });

  IotRepository createSubject() => IotRepository(iotApi: api);

  group('constructor', () {
    test('works properly', () {
      expect(createSubject, returnsNormally);
    });
  });
  group('get devices', () {
    test('makes correct api call', () async {
      final subject = createSubject();
      final devices = await subject.fetchDevices(startIndex: 0, count: 3);

      expect(devices, initDevices);

      verify(() => api.fetchDevices(startIndex: 0, count: 3)).called(1);
    });
  });
  group('get live data', () {
    test('return ', () async {
      expect(createSubject().fetchLiveData(), emitsInOrder([1,2,3,4]));

      verify(() => api.fetchLiveData()).called(1);
    });
  });
}
