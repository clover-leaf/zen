// ignore_for_file: prefer_const_constructors
import 'package:iot_gateway/iot_gateway.dart';
import 'package:test/test.dart';

void main() {
  group('GatewayClient', () {
    final broker = Broker(
      url: '192.168.1.7',
      port: 8883,
      username: 'vv',
      password: '1006',
    );
    GatewayClient createSubject({
      required Broker broker,
    }) {
      return GatewayClient(broker: broker);
    }

    group('constructor', () {
      test('returns normaly', () {
        expect(
          createSubject(broker: broker),
          isA<GatewayClient>(),
        );
      });
    });
    group('connect', () {
      test('connect successfully', () async {
        final subject = createSubject(broker: broker);
        await subject.connect();
      });
    });
    group('disconnect', () {
      test('disconnect successfully', () async {
        final subject = createSubject(broker: broker);
        await subject.connect();
        expect(subject.disconnect, returnsNormally);
      });
    });
  });
}
