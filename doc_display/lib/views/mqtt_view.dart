// ignore_for_file: unused_import, todo

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:doc_display/common/theme.dart';
import 'package:doc_display/models/mqtt.dart';
// import 'package:doc_display/models/mqtt.dart';

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
  // late final MqttManager mqttManager;

  @override
  void initState() {
    super.initState();
    // appState = Provider.of<MqttAppState>(context);
    // _startMqttClient();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MqttState appState = context.watch<MqttState>();
    if (kDebugMode) {
      print('MqttView build()');
    }

    return ScaffoldPage.scrollable(
        header: PageHeader(
          leading: // show the date and time of MqttAppState. _lastMessageDateTime.
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              '${appState.getLastMessageDateTime}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          title: Text('Coil Number: ${appState.getCoilNumber}'),
          // commandBar: ToggleSwitch(
          //   checked: appState.isConnected,
          //   onChanged: (v) {
          //     // if (v) {
          //     //   _startMqttClient();
          //     // } else {
          //     //   _stopMqttClient();
          //     // }
          //   },
          //   content:
          //       Text(appState.isConnected ? 'Connected' : 'Disconnected'),
          // ),
        ),
        children: <Widget>[
          _buildMessageViewer(
            object: appState.getCoilDivision,
            title: 'Division',
          ),
          _buildMessageViewer(
              object: appState.getCoilWinding, title: 'Winding'),
          _buildMessageViewer(
              object: appState.getCoilMaterial, title: 'Material'),
          _buildMessageViewer(
              object: appState.getCoilMaterialWidth,
              title: 'Material Width'),
          _buildMessageViewer(
              object: appState.getCoilPrevStop, title: 'Previous Stop'),
          _buildMessageViewer(
              object: appState.getCoilActiveStop, title: 'Active Stop'),
          _buildMessageViewer(
              object: appState.getCoilNextStop, title: 'Next Stop'),
          _buildDivider(),
          _buildScrollableTextBox(
            title: 'Mqtt Payload',
            text: appState.getReceivedText,
          ),
          _buildDivider(),
        ]);
  }

  Widget _buildMessageViewer({required String object, String? title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        child: TextBox(
          readOnly: true,
          padding: const EdgeInsetsDirectional.only(start: 30),
          placeholder: object,
          outsidePrefix: Padding(
              padding: const EdgeInsetsDirectional.only(start: 50),
              child: SizedBox(width: 150, child: Text(title ?? 'Title'))),
          outsideSuffix: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: IconButton(
              icon: const Icon(FluentIcons.sync),
              onPressed: () {},
            ),
            // ],
          ),
        ),
      ),
    );
    //return const MessageViewer();
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

  
}
