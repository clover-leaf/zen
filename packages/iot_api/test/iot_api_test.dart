import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

class TestIotApi extends IotApi {
  TestIotApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('IotApi', () {
    test('can be constructed', () {
      expect(TestIotApi.new, returnsNormally);
    });
  });
}
