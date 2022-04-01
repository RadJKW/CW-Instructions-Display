import 'package:flutter/foundation.dart';

enum MqttAppConnectionState {
  connecting,
  connected,
  disconnected,
  error,
}

class MqttAppState with ChangeNotifier {
  MqttAppConnectionState _appState = MqttAppConnectionState.disconnected;
  String _receivedText = '';
  int count = 0;

  void setReceivedText(String text) {
    _receivedText = text;
    count++;
    notifyListeners();
  }

  void setAppConnectionState(MqttAppConnectionState state) {
    _appState = state;
    notifyListeners();
  }

// create a getter that returns _counter.toString() and sets _receivedText to the value of the getter
  String get getReceivedText => _receivedText + ': $count';
  // createa a String Getter that returns a Text widget with 'connected' if _appState is connected and 'disconnected' if _appState is disconnected
  bool get isConnected => _appState == MqttAppConnectionState.connected;
  MqttAppConnectionState get getAppConnectionState => _appState;
}
