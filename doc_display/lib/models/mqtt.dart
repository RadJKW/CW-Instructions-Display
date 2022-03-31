import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:doc_display/state/mqtt_state.dart';

class MqttManager extends ChangeNotifier {
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
    _client!.port = 1883;
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = onDisconnected;
    _client!.autoReconnect = true;
    _client!.logging(on: true);

    /// Add the successful connection callback
    _client!.onConnected = onConnected;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    if (kDebugMode) {
      print('EXAMPLE::Mosquitto client connecting....');
    }
    _client!.connectionMessage = connMess;
  }

  // Connect to the host
  // ignore: avoid_void_async
  void connect() async {
    assert(_client != null);
    try {
      if (kDebugMode) {
        print('EXAMPLE::Mosquitto start client connecting....');
      }
      _currentState.setAppConnectionState(MqttAppConnectionState.connecting);
      await _client!.connect();
    } on Exception catch (e) {
      if (kDebugMode) {
        print('EXAMPLE::client exception - $e');
      }
      disconnect();
    }
  }

  void disconnect() {
    if (kDebugMode) {
      print('Disconnected');
    }
    _client!.disconnect();
  }

  /// The subscribed callback

  /// The unsolicited disconnect callback
  void onDisconnected() {
    if (kDebugMode) {
      print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    }
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      if (kDebugMode) {
        print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
      }
    }
    _currentState.setAppConnectionState(MqttAppConnectionState.disconnected);
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.setAppConnectionState(MqttAppConnectionState.connected);
    if (kDebugMode) {
      print('EXAMPLE::Mosquitto client connected....');
    }
    _client!.subscribe(_topic, MqttQos.atLeastOnce);
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      // ignore: avoid_as
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      // final MqttPublishMessage recMess = c![0].payload;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      if (kDebugMode) {
        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      }
      if (kDebugMode) {
        print('');
      }
    });
    if (kDebugMode) {
      print(
          'EXAMPLE::OnConnected client callback - Client connection was successful');
    }
  }
}
  
// static MqttStateService of(BuildContext context) =>
//     Provider.of<MqttStateService>(context, listen: false);

// create a global variable to hold the mqtt broker address

// const String broker = '192.168.0.30';
// final clientID = const ShortUuid().generate();
 


// Future connect(BuildContext context, String deviceID) async { 
//   var _client = MqttServerClient(broker, clientID);
//   if _client == null{ 
//     _client = MqttServerClient(broker, clientID);
//     _client!.autoReconnect = true; 
//     _client!.clientIdentifier = clientID;
//     await _client!.connect();
//   }
// }

// class AppStateService extends ChangeNotifier {
//   static AppStateServiceinstance;
//   static AppStateService instance {
//     _instance ??= AppStateService();AppStateService
//     return _instance!;
//   }

//   static const mqttServerAddress = '165.227.50.183';
//   final clientId = ShortUuid().generate();
//      MqttClientPayloadBuilder()

//   Future connect(BuildContext context, String deviceId) async { // Device Id CW88
//     if (_client == null) {
//       _client = MqttServerClient(mqttServerAddress, id);
//       _client!.autoReconnect = true;
//       _client!.clientIdentifier = clientId;
//       await _client!.connect(clientId, password);
//     }

//     _client!.onAutoReconnect = () => print("Reconnecting");
//     _client!.onDisconnected = () => print("disconnected");
//     }
// /*

//     if (message) {
//     rec[0].topic.endsWith('blah')e
// {
//     visiblePage = Pages.PDF;
//     notifyListeners();
// }


// In main.dart to pick which page is visible.

// if (MyService.visiblePage == Pages.pdf) {
//     return PdfPage();
// }
// else if (== Pages.Video){
// return VideoPage();
// }*/

//     try {
//       _client!.updates!.listen((rec) {
//         final message = rec[0].payload as MqttPublishMessage;
//         final payload =
//             MqttPublishPayload.bytesToStringAsString(message.payload.message);


// if (rec[0].topic.endsWith('blah'))
// {
//     visiblePage = Pages.PDF;
//     notifyListeners();
//         notifyListeners();
//       });

//       _client!.subscribe('outing/$id', MqttQos.atLeastOnce);
//       _client!.subscribe('outing/$id/loc/+', MqttQos.atLeastOnce);
//       _client!.subscribe('outing/$id/clients/+', MqttQos.atLeastOnce);
//       _publishUser(id);
//       await _startLocation(id);
//       notifyListeners();
//     } catch (ex) {
//       print(ex);
//     }
//   // locations.clear();
//     // clients.clear();
//     // _outing = null;
//     // notifyListeners();
//     }
