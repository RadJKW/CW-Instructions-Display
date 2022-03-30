import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:short_uuids/short_uuids.dart';

class AppStatevice extends ChangeNotifier {
  static AppStateServiceinstance;
  static AppStateService instance {
    _instance ??= AppStateService();AppStateService
    return _instance!;
  }

  static const mqttServerAddress = '165.227.50.183';
  final clientId = ShortUuid().generate();
     MqttClientPayloadBuilder()

  Future connect(BuildContext context, String deviceId) async { // Device Id CW88
    if (_client == null) {
      _client = MqttServerClient(mqttServerAddress, id);
      _client!.autoReconnect = true;
      _client!.clientIdentifier = clientId;
      await _client!.connect(clientId, password);
    }

    _client!.onAutoReconnect = () => print("Reconnecting");
    _client!.onDisconnected = () => print("disconnected");
    }
/*

    if (message) {
    rec[0].topic.endsWith('blah')e
{
    visiblePage = Pages.PDF;
    notifyListeners();
}


In main.dart to pick which page is visible.

if (MyService.visiblePage == Pages.pdf) {
    return PdfPage();
}
else if (== Pages.Video){
return VideoPage();
}*/

    try {
      _client!.updates!.listen((rec) {
        final message = rec[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);


if (rec[0].topic.endsWith('blah'))
{
    visiblePage = Pages.PDF;
    notifyListeners();
        notifyListeners();
      });

      _client!.subscribe('outing/$id', MqttQos.atLeastOnce);
      _client!.subscribe('outing/$id/loc/+', MqttQos.atLeastOnce);
      _client!.subscribe('outing/$id/clients/+', MqttQos.atLeastOnce);
      _publishUser(id);
      await _startLocation(id);
      notifyListeners();
    } catch (ex) {
      print(ex);
    }
  } // locations.clear();
    // clients.clear();
    // _outing = null;
    // notifyListeners();
  }
}
