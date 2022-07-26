import 'package:flutter_firestore/tiles_overview/bloc/tiles_overview_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_api/iot_api.dart';
import 'package:mocktail/mocktail.dart';

class MockTileConfig extends Mock implements TileConfig {}

void main() {
  late MockTileConfig mockTileConfig;
  setUp(() {
    mockTileConfig = MockTileConfig();
  });
  group('BrokerSubscriptionRequested', () {
    test('supports value equality', () {
      expect(
        const BrokerSubscriptionRequested(),
        equals(const BrokerSubscriptionRequested()),
      );
    });
    test('props are correct', () {
      expect(
        const BrokerSubscriptionRequested().props,
        equals(<Object>[]),
      );
    });
  });
  group('MqttDeviceSubscriptionRequested', () {
    test('supports value equality', () {
      expect(
        const MqttDeviceSubscriptionRequested(),
        equals(const MqttDeviceSubscriptionRequested()),
      );
    });
    test('props are correct', () {
      expect(
        const MqttDeviceSubscriptionRequested().props,
        equals(<Object>[]),
      );
    });
  });
  group('TileConfigSubscriptionRequested', () {
    test('supports value equality', () {
      expect(
        const TileConfigSubscriptionRequested(),
        equals(const TileConfigSubscriptionRequested()),
      );
    });
    test('props are correct', () {
      expect(
        const TileConfigSubscriptionRequested().props,
        equals(<Object>[]),
      );
    });
  });
  group('GatewayClientInitialized', () {
    test('supports value equality', () {
      expect(
        const GatewayClientInitialized(
          brokerView: {},
          mqttDeviceView: {},
          tileConfigView: {},
        ),
        equals(
          const GatewayClientInitialized(
            brokerView: {},
            mqttDeviceView: {},
            tileConfigView: {},
          ),
        ),
      );
    });
    test('props are correct', () {
      expect(
        const GatewayClientInitialized(
          brokerView: {},
          mqttDeviceView: {},
          tileConfigView: {},
        ).props,
        equals([
          <FieldId, Broker>{},
          <FieldId, MqttDevice>{},
          <FieldId, TileConfig>{}
        ]),
      );
    });
  });
  group('MqttSubscribed', () {
    test('supports value equality', () {
      expect(
        const MqttSubscribed(),
        equals(const MqttSubscribed()),
      );
    });
    test('props are correct', () {
      expect(
        const MqttSubscribed().props,
        equals(<Object>[]),
      );
    });
  });
  group('ActionPublished', () {
    test('supports value equality', () {
      expect(
        ActionPublished(
          tileConfig: mockTileConfig,
          payload: '',
        ),
        equals(
          ActionPublished(
            tileConfig: mockTileConfig,
            payload: '',
          ),
        ),
      );
    });
    test('props are correct', () {
      expect(
        ActionPublished(
          tileConfig: mockTileConfig,
          payload: '',
        ).props,
        equals([mockTileConfig, '']),
      );
    });
  });
}
