// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:doc_display/models/coil.dart';

enum MqttAppConnectionState {
  connecting,
  connected,
  disconnected,
  error,
}
class MqttAppState with ChangeNotifier {
  // void connectToMqtt() {
    
  MqttAppConnectionState _appState = MqttAppConnectionState.disconnected;
  Coil?  _coil;
  String _receivedText = '';
  int _pageIndex = 4;
  // variable to hold date and time of last message
  DateTime? _lastMessageDateTime;

  void setReceivedText(String text) {
    _receivedText = text;
    Map<String, dynamic> coilJson = jsonDecode(_receivedText);
    _coil = Coil.fromJson(coilJson);
    // update the _lastMessageDateTime
    _lastMessageDateTime = DateTime.now();
    // iff _pageindex is not 4 then call setCurrentPage to 4 


    if (_pageIndex != 4) {
      setCurrentPage(4);
    }
    notifyListeners();
  }

  void setAppConnectionState(MqttAppConnectionState state) {
    _appState = state;
    notifyListeners();
  }

  void setCurrentPage(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  // create a new setter for the status of the mqtt connection
  





  MqttAppConnectionState get getAppConnectionState => _appState;

  int get getCurrentPage => _pageIndex;
  String? get getLastMessageDateTime => _lastMessageDateTime?.toString();
  String get getReceivedText => _receivedText;
  String get isConnectedText => _appState == MqttAppConnectionState.connected
      ? 'Connected'
      : 'Disconnected';
  
  String get getCoilNumber => _coil?.number  ?? '';
  String get getCoilDivision => _coil?.division ?? '';
  String get getCoilWinding => _coil?.winding ?? '';
  String get getCoilMaterial => _coil?.material ?? '';
  String get getCoilMaterialWidth => _coil?.materialWidth ?? '';
  String get getCoilPrevStop => _coil?.prevStop ?? '';
  String get getCoilActiveStop => _coil?.activeStop ?? '';
  String get getCoilNextStop => _coil?.nextStop ?? '';

  bool get isConnected => _appState == MqttAppConnectionState.connected;
}
