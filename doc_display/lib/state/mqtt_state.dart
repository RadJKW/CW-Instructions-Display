
import 'package:flutter/foundation.dart';

enum MqttAppConnectionState {
  connecting,
  connected,
  disconnected,
  error,
}
class MqttAppState with ChangeNotifier{
  MqttAppConnectionState _appState = MqttAppConnectionState.disconnected;
  String _receivedText = '';

  void setReceivedText(String text) {
    _receivedText = text;
    notifyListeners();
  }
  void setAppConnectionState(MqttAppConnectionState state) {
    _appState = state;
    notifyListeners();
  }

  String get getReceivedText => _receivedText;
  MqttAppConnectionState get getAppConnectionState => _appState;

  // create a getter to check if the app is connected
  // return true if the app is connected
  // return false if the app is not connected

  bool get isConnected => _appState == MqttAppConnectionState.connected;

}