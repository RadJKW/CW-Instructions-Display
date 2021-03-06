// ignore_for_file: avoid_print

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:doc_display/state/mqtt_state.dart';

class MqttManager {
  // Private instance of client
  final MqttAppState _currentState;
  MqttServerClient? _client;
  final String _identifier;
  final String _host;
  final String _topic;

  // Constructor
  // ignore: sort_constructors_first
  MqttManager(
      {required String host,
      required String topic,
      required String identifier,
      required MqttAppState state})
      : _identifier = identifier,
        _host = host,
        _topic = topic,
        _currentState = state;

  void initializeMqttClient() {
    _client = MqttServerClient(_host, _identifier);
    _client!.setProtocolV311();
    _client!.port = 1883;
    _client!.keepAlivePeriod = 120;
    _client!.onDisconnected = onDisconnected;
    _client!.secure = false;
    _client!.logging(on: true);

    /// Add the successful connection callback
    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    _client!.connectionMessage = connMess;
  }

  // Connect to the host
  // ignore: avoid_void_async
  void connect() async {
    assert(_client != null);
    try {
      print('EXAMPLE::Mosquitto start client connecting....');
      _currentState.setAppConnectionState(MqttAppConnectionState.connecting);
      await _client!.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client!.disconnect();
  }

  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    _currentState.setAppConnectionState(MqttAppConnectionState.disconnected);
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.setAppConnectionState(MqttAppConnectionState.connected);
    print('EXAMPLE::Mosquitto client connected....');
    _client!.subscribe(_topic, MqttQos.atLeastOnce);
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      // ignore: avoid_as
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      // final MqttPublishMessage recMess = c![0].payload;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
    print(
        'EXAMPLE::OnConnected client callback - Client connection was successful');
  }
}


// class MqttManager extends ChangeNotifier {
//   // Private instance of client
//   final MqttAppState _currentState;
//   MqttServerClient? _client;
//   final String _identifier;
//   final String _host;
//   final String _topic;

//   // Constructor
//   // ignore: sort_constructors_first
//   MqttManager(
//       {required String host,
//       required String topic,
//       required String identifier,
//       required MqttAppState state})
//       : _identifier = identifier,
//         _host = host,
//         _topic = topic,
//         _currentState = state;

//   void initializeMqttClient() {
//     _client = MqttServerClient(_host, _identifier);
//     _client!.port = 1883;
//     _client!.keepAlivePeriod = 20;
//     _client!.onDisconnected = onDisconnected;
//     _client!.autoReconnect = true;
//     _client!.secure = false;
//     _client!.logging(on: true);

//     /// Add the successful connection callback
//     _client!.onConnected = onConnected;

//     final MqttConnectMessage connMess = MqttConnectMessage()
//         .withClientIdentifier(_identifier)
//         .withWillTopic(
//             'willtopic') // If you set this you must set a will message
//         .withWillMessage('My Will message')
//         .startClean() // Non persistent session for testing
//         .withWillQos(MqttQos.atLeastOnce);
//     if (kDebugMode) {
//       print('EXAMPLE::Mosquitto client connecting....');
//     }
//     _client!.connectionMessage = connMess;
//   }

//   // Connect to the host
//   // ignore: avoid_void_async
//   void connect() async {
//     assert(_client != null);
//     try {
//       if (kDebugMode) {
//         print('EXAMPLE::Mosquitto start client connecting....');
//       }
//       _currentState.setAppConnectionState(MqttAppConnectionState.connecting);
//       await _client!.connect();
//     } on Exception catch (e) {
//       if (kDebugMode) {
//         print('EXAMPLE::client exception - $e');
//       }
//       disconnect();
//     }
//   }

//   void disconnect() {
//     if (kDebugMode) {
//       print('Disconnected');
//     }
//     _client!.disconnect();
//   }

//   /// The subscribed callback

//   /// The unsolicited disconnect callback
//   void onDisconnected() {
//     if (kDebugMode) {
//       print('EXAMPLE::OnDisconnected client callback - Client disconnection');
//     }
//     if (_client!.connectionStatus!.returnCode ==
//         MqttConnectReturnCode.noneSpecified) {
//       if (kDebugMode) {
//         print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
//       }
//     }
//     _currentState.setAppConnectionState(MqttAppConnectionState.disconnected);
//   }

//   /// The successful connect callback
//   void onConnected() {
//     _currentState.setAppConnectionState(MqttAppConnectionState.connected);
//     if (kDebugMode) {
//       print('EXAMPLE::Mosquitto client connected....');
//     }
//     _client!.subscribe(_topic, MqttQos.atLeastOnce);
//     _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
//       // ignore: avoid_as
//       final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

//       // final MqttPublishMessage recMess = c![0].payload;
//       final String pt =
//           MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//       _currentState.setReceivedText(pt);
//       if (kDebugMode) {
//         print(
//             'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
//       }
//       if (kDebugMode) {
//         print('');
//       }
//     });
//     if (kDebugMode) {
//       print(
//           'EXAMPLE::OnConnected client callback - Client connection was successful');
//     }
//   }
// }
