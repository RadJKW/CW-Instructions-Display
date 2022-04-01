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
  MqttAppConnectionState _appState = MqttAppConnectionState.disconnected;
  Coil?  _coil;
  String _receivedText = '';
  int count = 0;

  void setReceivedText(String text) {
    _receivedText = text;
    Map<String, dynamic> coilJson = jsonDecode(_receivedText);
    _coil = Coil.fromJson(coilJson);
    //debug print to console each coil attribute

    notifyListeners();
  }

  void setAppConnectionState(MqttAppConnectionState state) {
    _appState = state;
    notifyListeners();
  }

  MqttAppConnectionState get getAppConnectionState => _appState;

  String get getReceivedText => _receivedText + ': $count';
  String get isConnectedText => _appState == MqttAppConnectionState.connected
      ? 'Connected'
      : 'Disconnected';
  // create a getter for each coil attribute: winding, material,materialWidth,prevStop,activeStop,nextStop;
  
  String get getCoilNumber => _coil?.getNumber  ?? '';
  String get getCoilDivision => _coil?.getDivision ?? '';
  String get getCoilWinding => _coil?.getWinding ?? '';
  String get getCoilMaterial => _coil?.getMaterial ?? '';
  String get getCoilMaterialWidth => _coil?.getMaterialWidth ?? '';
  String get getCoilPrevStop => _coil?.getPrevStop ?? '';
  String get getCoilActiveStop => _coil?.getActiveStop ?? '';
  String get getCoilNextStop => _coil?.getNextStop ?? '';

  bool get isConnected => _appState == MqttAppConnectionState.connected;
}
