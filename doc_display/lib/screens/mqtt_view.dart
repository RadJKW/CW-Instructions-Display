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
  late MqttAppState currentState;
  late MqttManager mqttManager;

  @override
  void initState() {
    super.initState();
    /* 
      insert code here
    */
  }

  @override
  void dispose() {
    /*  
      insert code here
    */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('MqttView build()');
    }
    return Consumer<MqttAppState>(builder: (context, state, child) {
      if (kDebugMode) {
        print('textbox rebuild');
      }
      currentState = state;
      _startMqttClient();
      return ScaffoldPage.scrollable(
          header: PageHeader(
            title: const Text('MQTT BROKER ADDRESS'),
            // TODO: Change the command bar toggle switch to mqtt status indicator
            commandBar: ToggleSwitch(
              checked: state.isConnected,
              onChanged: (bool value) {},
              content: const Text('Disabled'),
            ),
          ),
          children: [
            const MessageViewer(),
            const Divider(
              direction: Axis.horizontal,
              style: DividerThemeData(
                // verticalMargin: EdgeInsets.all(10),
                horizontalMargin: EdgeInsets.fromLTRB(0, 30, 0, 15),
                thickness: 3,
              ),
            ),
            TextBox(
              header: 'Mqtt Payload',
              maxLines: null,
              readOnly: true,
              suffixMode: OverlayVisibilityMode.always,
              minHeight: 100,
              // suffix: _clearController.text.isEmpty
              //     ? null
              //     : IconButton(
              //         icon: const Icon(FluentIcons.chrome_close),
              //         onPressed: () {
              //           _clearController.clear();
              //         },
              //       ),
              placeholder: state.getReceivedText,
            ),
          ]);
    });
  }

  void _startMqttClient() {
    mqttManager = MqttManager(
      host: '192.168.0.30',
      topic: 'pi/cw88/#',
      identifier: 'radpi-cw88',
      state: currentState,
    );
    //TODO: uncommenting the following lines caused mqtt infinite 'print'/'debug' loop.
    // mqttManager.initializeMqttClient();
    // mqttManager.connect();
  }
}
