/// Enumeration that indicates various client connection states
enum ConnectionStatus {
  /// The MQTT Connection is in the process of disconnecting from the broker.
  disconnecting,

  /// MQTT Connection is not currently connected to any broker.
  disconnected,

  /// The MQTT Connection is in the process of connecting to the broker.
  connecting,

  /// The MQTT Connection is currently connected to the broker.
  connected,

  /// The MQTT Connection is faulted and no longer communicating
  /// with the broker.
  faulted
}
