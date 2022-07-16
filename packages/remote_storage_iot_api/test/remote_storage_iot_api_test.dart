// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iot_api/iot_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_storage_iot_api/remote_storage_iot_api.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('RemoteStorageIotApi', () {
    // late MockClient client;
    late http.Client client;

    final device = Device(
      id: 4,
      deviceName: 'Air sensor XII',
      parentId: 1,
      status: Status.running,
      deviceType: DeviceType.gadget,
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
    );
    final station = Station(
      id: 4,
      stationName: 'Silo A',
      phoneNumber: 'phoneNumber',
      balance: 'balance',
      expiredDate: DateTime.parse('2022-06-10T21:05:06.000Z'),
      qualityScore: 100,
      city: 'city',
      district: 'district',
      ward: 'ward',
      longitude: 100,
      latitude: 100,
      addressDetail: 'addressDetail',
      createAt: DateTime.parse('2022-06-10T21:05:06.000Z'),
      createBy: 0,
      startDate: DateTime.parse('2022-06-10T21:05:06.000Z'),
      endDate: DateTime.parse('2022-06-10T21:05:06.000Z'),
      deleteAt: DateTime.parse('2022-06-10T21:05:06.000Z'),
      deleteBy: 1,
      updateAt: DateTime.parse('2022-06-10T21:05:06.000Z'),
      updateBy: 1,
      description: 'Silo A description',
    );
    final project = Project(
      id: 4,
      projectName: 'name',
      salePersonId: 1,
      customerId: 1,
      city: 'city',
      district: 'district',
      ward: 'ward',
      longitude: 100,
      latitude: 100,
      addressDetail: 'addressDetail',
      createAt: DateTime.parse('2022-06-10T21:05:06.000Z'),
      createBy: 0,
      fileAttached: 'fileAttached',
      startDate: DateTime.parse('2022-06-10T21:05:06.000Z'),
      endDate: DateTime.parse('2022-06-10T21:05:06.000Z'),
      deleteAt: DateTime.parse('2022-06-10T21:05:06.000Z'),
      deleteBy: 1,
      updateAt: DateTime.parse('2022-06-10T21:05:06.000Z'),
      updateBy: 1,
      description: 'project description',
    );

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    setUp(() {
      // client = http.Client();
      client = MockClient();
      when(() => client.get(any())).thenAnswer((input) async {
        final uri = input.positionalArguments[0] as Uri;
        if (uri.path.contains('project/countall')) {
          return http.Response(jsonEncode({'count': 1}), 200);
        } else if (uri.path.contains('device/countall')) {
          return http.Response(jsonEncode({'count': 1}), 200);
        } else if (uri.path.contains('project/getnproject')) {
          return http.Response(jsonEncode([project]), 200);
        } else if (uri.path.contains('device/getndevice')) {
          return http.Response(jsonEncode([device]), 200);
        }else if (uri.path.contains('station/getallstationinproject')) {
          return http.Response(jsonEncode([station]), 200);
        } else if (uri.path.contains('device/getalldeviceinproject')) {
          return http.Response(jsonEncode([device]), 200);
        } else if (uri.path.contains('device/getalldeviceinstation')) {
          return http.Response(jsonEncode([device]), 200);
        }
        return http.Response(jsonEncode(20), 400);
      });
    });

    RemoteStorageIotApi createSubject() =>
        RemoteStorageIotApi(httpClient: client, schema: 'demo');

    group('constructor', () {
      test('works properly', () {
        expect(createSubject, returnsNormally);
      });
    });

    group('countProject', () {
      test('fetchs successfully', () async {
        final subject = createSubject();
        expect(await subject.countProject(), 1);
      });
    });
    group('countDevice', () {
      test('fetchs successfully', () async {
        final subject = createSubject();
        expect(await subject.countDevice(), 1);
      });
    });
    group('getNProject', () {
      test('fetchs successfully', () async {
        final subject = createSubject();
        expect(await subject.getNProject(), [project]);
      });
    });    
    group('getNDevice', () {
      test('fetchs successfully', () async {
        final subject = createSubject();
        expect(await subject.getNDevice(), [device]);
      });
    });
    group('getAllStationInProject', () {
      test('fetchs successfully', () async {
        final subject = createSubject();
        expect(await subject.getAllStationInProject(projectId: 1), [station]);
      });
    });    
    group('getAllDeviceInProject', () {
      test('fetchs successfully', () async {
        final subject = createSubject();
        expect(await subject.getAllDeviceInProject(projectId: 1), [device]);
      });
    });
    group('getAllDeviceInStation', () {
      test('fetchs successfully', () async {
        final subject = createSubject();
        expect(await subject.getAllDeviceInStation(stationId: 1), [device]);
      });
    });
  });
}
