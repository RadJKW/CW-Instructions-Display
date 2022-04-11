

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:doc_display/models/coil.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MqttConnectionState {
  connecting,
  connected,
  disconnected,
  disconnecting,
  error,
}

class MqttState with ChangeNotifier {
  // void connectToMqtt() {
  final _client = MqttServerClient('192.168.0.30', 'flutter-pi-cw88');
  final String _topic = 'pi/cw88/#';

  MqttConnectionState _appState = MqttConnectionState.disconnected;
  Coil? _coil;
  String _receivedText = '';
  int _pageIndex = 4;
  DateTime? _lastMessageDateTime;

  MqttState() {
    _client
      ..logging(on: false)
      ..setProtocolV311()
      ..keepAlivePeriod = 20
      ..onDisconnected = onDisconnected
      ..onConnected = onConnected
      ..onSubscribed = onSubscribed
      ..secure = false
      ..autoReconnect = true;
    _buildConnectionMessage();
    _connectClient();
  }

  void setReceivedText(String text) {
    _receivedText = text;
    Map<String, dynamic> coilJson = jsonDecode(_receivedText);
    _coil = Coil.fromJson(coilJson);
    _lastMessageDateTime = DateTime.now();
    if (_pageIndex != 4) {
      setCurrentPage(4);
    }
    notifyListeners();
  }

  void setAppConnectionState(MqttConnectionState state) {
    _appState = state;
    notifyListeners();
  }

  void setCurrentPage(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  void _buildConnectionMessage() {
    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('flutter-pi-cw88')
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMess;
  }

  void _connectClient() async {
    try {
      await _client.connect();
    } on NoConnectionException catch (e) {
      if (kDebugMode) {
        if (kDebugMode) {
      }
        print('EXAMPLE::client exception - $e');
      }
      _client.disconnect();
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('EXAMPLE::socket exception - $e');
      }
      _client.disconnect();
    }
  }

  void _subscribeToTopic() {
    _client.subscribe(_topic, MqttQos.atLeastOnce);
  }

  void _listenToTopic() {
    _client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      // ignore: avoid_as
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      // final MqttPublishMessage recMess = c![0].payload;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      setReceivedText(pt);
      if (kDebugMode) {
        print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      }
      if (kDebugMode) {
        print('');
      }
    });
  }

  void connectClient() {
    _connectClient();
  }

  void disconnectClient() {
    _client.disconnect();
    onDisconnected();
    // _disconnectClient();
  }

  void onConnected() {
    setAppConnectionState(MqttConnectionState.connected);
    if (kDebugMode) {
      print('EXAMPLE::Mosquitto client connected....');
    }
    _subscribeToTopic();
    _listenToTopic();
    if (kDebugMode) {
      print(
        'EXAMPLE::OnConnected client callback - Client connection was successful');
    }
  }

  void onDisconnected() {
    if (kDebugMode) {
      print('EXAMPLE::On disconnected called');
    }
    setAppConnectionState(MqttConnectionState.disconnected);
  }

  void onSubscribed(String topic) {
    if (kDebugMode) {
      print('EXAMPLE::On subscribed called');
    }
    setAppConnectionState(MqttConnectionState.connected);
  }

  // create a new setter for the status of the mqtt connection

  MqttConnectionState get getAppConnectionState => _appState;

  int get getCurrentPage => _pageIndex;
  String? get getLastMessageDateTime => _lastMessageDateTime?.toString();
  String get getReceivedText => _receivedText;
  String get isConnectedText =>
      _appState == MqttConnectionState.connected ? 'Connected' : 'Disconnected';

  String get getCoilNumber => _coil?.number ?? '';
  String get getCoilDivision => _coil?.division ?? '';
  String get getCoilWinding => _coil?.winding ?? '';
  String get getCoilMaterial => _coil?.material ?? '';
  String get getCoilMaterialWidth => _coil?.materialWidth ?? '';
  String get getCoilPrevStop => _coil?.prevStop ?? '';
  String get getCoilActiveStop => _coil?.activeStop ?? '';
  String get getCoilNextStop => _coil?.nextStop ?? '';

  bool get isConnected => _appState == MqttConnectionState.connected;
}
