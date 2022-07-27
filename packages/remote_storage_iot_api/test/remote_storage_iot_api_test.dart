import 'package:iot_api/iot_api.dart';
import 'package:remote_storage_iot_api/remote_storage_iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('RemoteStorageIotApi', () {
    final broker = Broker(
      id: '63c59d69-0388-45f6-b0a3-a525e0afce38',
      title: 'mosquitto',
      url: '192.168.1.7',
      port: 8883,
      username: 'vv',
      password: '1006',
    );

    final projects = [
      Project(
        id: '99b2be2f-b082-483f-92b2-56585e6935b0',
        title: 'My home',
        brokerID: '63c59d69-0388-45f6-b0a3-a525e0afce38',
      ),
    ];

    final devices = [
      Device(
        id: '6d034377-1bac-4c75-828f-b1999f87a05f',
        projectID: '99b2be2f-b082-483f-92b2-56585e6935b0',
        title: 'DHT-22 sensor',
        topic: 'esp',
        jsonEnable: true,
        jsonVariables: [
          JsonVariable(
            id: '681b7a7a-2a28-462d-ab77-564f44b35896',
            deviceID: '6d034377-1bac-4c75-828f-b1999f87a05f',
            title: 'temperature',
            jsonExtraction: r"$['temp']",
          ),
          JsonVariable(
            id: '30364bf7-0be3-4d0d-add5-43c323b1fcdf',
            deviceID: '6d034377-1bac-4c75-828f-b1999f87a05f',
            title: 'himidity',
            jsonExtraction: r"$['humid']",
          ),
        ],
      ),
    ];

    final tileConfigs = [
      TileConfig(
        id: '3b49cf6b-fd4e-4cb0-84e3-c800fa42a6e2',
        title: 'Kitchen temperature',
        deviceID: '6d034377-1bac-4c75-828f-b1999f87a05f',
        tileType: TileType.text,
        tileData: const TextTileData(
          prefix: '',
          postfix: '℃',
          jsonVariableID: '681b7a7a-2a28-462d-ab77-564f44b35896',
        ),
      ),
    ];

    RemoteStorageIotApi createSubject() => RemoteStorageIotApi();

    group('constructor', () {
      test('works properly', () {
        expect(createSubject, returnsNormally);
      });
    });
    group('getBroker', () {
      test('props properly', () {
        final subject = createSubject();
        expect(subject.getBroker(), broker);
      });
    });
    group('refreshProject', () {
      test('props properly', () {
        final subject = createSubject();
        expect(subject.refreshProject(), projects);
      });
    });
    group('refreshDevice', () {
      test('props properly', () {
        final subject = createSubject();
        expect(subject.refreshDevice(), devices);
      });
    });
    group('refreshTileConfig', () {
      test('props properly', () {
        final subject = createSubject();
        expect(subject.refreshTileConfig(), tileConfigs);
      });
    });
    group('initializes stream', () {
      group('initializes broker correctly', () {
        test('props properly', () {
          final subject = createSubject();
          expect(subject.getProjects(), emits(projects));
        });
      });
      group('initializes device correctly', () {
        test('props properly', () {
          final subject = createSubject();
          expect(subject.getDevices(), emits(devices));
        });
      });
      group('initializes tileConfig correctly', () {
        test('props properly', () {
          final subject = createSubject();
          expect(subject.getTileConfigs(), emits(tileConfigs));
        });
      });
    });
    group('saveTileConfig', () {
      test('saves new tile config', () {
        final subject = createSubject();
        final newTileConfig = TileConfig(
          title: 'new tile',
          deviceID: 'deviceID',
          tileType: TileType.text,
          tileData: TextTileData.placeholder(),
        );
        subject.saveTileConfig(newTileConfig);
        expect(
          subject.getTileConfigs(),
          emits([
            ...tileConfigs,
            newTileConfig,
          ]),
        );
      });
      test('update tile config', () {
        final subject = createSubject();
        final newTileConfig = tileConfigs[0].copyWith(
          title: 'update title',
        );
        subject.saveTileConfig(newTileConfig);
        expect(
          subject.getTileConfigs(),
          emits([
            newTileConfig,
          ]),
        );
      });
    });
  });
}
