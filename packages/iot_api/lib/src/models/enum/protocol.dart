/// Status of device
enum Protocol {

  ///
  http,

  /// 
  mqtt,
}

/// helper
extension ProtocolX on Protocol {
  /// get name
  String getName() {
    switch (this) {
      case Protocol.http:
        return 'Http';
      case Protocol.mqtt:
        return 'Mqtt';
    }
  }
}
