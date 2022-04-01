// ignore_for_file: unused_import, todo

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:doc_display/widgets/msg_view_card.dart';
import 'package:doc_display/common/theme.dart';
import 'package:doc_display/screens/mqtt_view.dart';
import 'package:doc_display/state/mqtt_state.dart';
import 'package:doc_display/models/mqtt.dart';

// TODO: import required packages
//    mqtt_client
//    mqtt_client_server
// TODO: Generate State(full / less) widget with init & dispose
// TODO: Populate with read only text box widgets
//    add titles to the text boxes for the topic

class MqttView extends StatefulWidget {
  const MqttView({Key? key}) : super(key: key);

  @override
  State<MqttView> createState() => _MqttViewState();
}

class _MqttViewState extends State<MqttView> {
  late MqttAppState _mqttAppState;
  late MqttManager mqttManager;

  @override
  void initState() {
    super.initState();
    // _mqttAppState = Provider.of<MqttAppState>(context);
    // _startMqttClient();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MqttAppState appState = context.watch<MqttAppState>();
    _mqttAppState = appState;
    bool isChecked = false;
    if (kDebugMode) {
      print('MqttView build()');
    }

    return ScaffoldPage.scrollable(
        header: PageHeader(
          title: const Text('MQTT BROKER ADDRESS'),
          // TODO: Change the command bar toggle switch to mqtt status indicator
          commandBar: ToggleSwitch(
            checked: _mqttAppState.isConnected,
            onChanged: (bool value) {
              //
            },
            content: Text(_mqttAppState.getAppConnectionState.toString()),
          ),
        ),
        children: <Widget>[
          _buildMessageViewer(),
          _buildDivider(),
          _buildScrollableTextBox(
            title: 'Mqtt Payload',
            text: _mqttAppState.getReceivedText,
          ),
          _buildDivider(),
          _buildConnectButtonFrom(_mqttAppState.getAppConnectionState),
        ]);
  }

  Widget _buildMessageViewer() {
    return const MessageViewer();
  }

  Widget _buildDivider() {
    return const Divider(
      direction: Axis.horizontal,
      style: DividerThemeData(
        // verticalMargin: EdgeInsets.all(10),
        horizontalMargin: EdgeInsets.fromLTRB(0, 30, 0, 15),
        thickness: 3,
      ),
    );
  }

  Widget _buildScrollableTextBox({String? text, String? title}) {
    return TextBox(
      header: title ?? '',
      maxLines: null,
      readOnly: true,
      suffixMode: OverlayVisibilityMode.always,
      minHeight: 100,
      placeholder: text ?? 'hello world',
    );
  }

  // build a widget '_buildConnectButtonFrom (MqttAppConnectionState)
  // the widget will return a button with the text 'Connect' when MqttAppConnectionState is 'disconnected' 
  // and 'Disconnect' when MqttAppConnectionState is 'connected'

  Widget _buildConnectButtonFrom(MqttAppConnectionState state) {
    return Button(
      child: Text( state == MqttAppConnectionState.disconnected
          ? 'Connect'
          : 'Disconnect'),
      onPressed: () {
        if (state == MqttAppConnectionState.disconnected) {
          _startMqttClient();
        } else {
          _stopMqttClient();
        }
      },
    );
  }

  void _startMqttClient() {
    mqttManager = MqttManager(
      host: '192.168.0.17',
      topic: 'pi/cw88/#',
      identifier: 'radpi-cw88',
      state: _mqttAppState,
    );
    //TODO: uncommenting the following lines caused mqtt infinite 'print'/'debug' loop.
    mqttManager.initializeMqttClient();
    mqttManager.connect();
  }

  void _stopMqttClient() {
    mqttManager.disconnect();
  }
}
