// ignore_for_file: prefer_const_constructors
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
      deviceType: 1,
      serialNumber: '1asda',
      createAt: DateTime.parse('2022-06-10T21:05:06.000Z'),
      createBy: 1,
      startDate:DateTime.parse('2022-06-10T21:05:06.000Z'),
      endDate: DateTime.parse('2022-06-21T21:05:06.000Z'),
      deleteAt: DateTime.parse('2022-06-22T21:05:06.000Z'),
      deleteBy: 1,
      updateAt: DateTime.parse('2022-06-13T21:05:06.000Z'),
      updateBy: 1,
      description: 'Air sensor XII description',
    );

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    setUp(() {
      client = http.Client();
      // client = MockClient();
      // when(() => client.get(any())).thenAnswer((input) async {
      //   final uri = input.positionalArguments[0] as Uri;
      //   if (uri.path.contains('getndevice')) {
      //     return http.Response(jsonEncode([device]), 200);
      //   }
      //   return http.Response(jsonEncode(20), 200);
      // });
    });

    RemoteStorageIotApi createSubject() =>
        RemoteStorageIotApi(httpClient: client, schema: 'test_6');

    group('constructor', () {
      test('works properly', () {
        expect(createSubject, returnsNormally);
      });
    });

    group('fetch devices', () {
      test('fetch devices', () async {
        final subject = createSubject();
        expect(await subject.fetchDevices(startIndex: 3, count: 1), [device]);
      });
    });
    group('count number of devices', () {
      test('count number of devices', () async {
        final subject = createSubject();
        expect(await subject.getNumberOfDevices(), 4);
      });
    });
  });
}
