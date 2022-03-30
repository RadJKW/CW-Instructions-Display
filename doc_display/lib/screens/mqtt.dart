// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:doc_display/widgets/messageViewCard.dart';

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
  bool mqttStatus = false;

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
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('Inputs showcase'),
        // TODO: Change the command bar toggle switch to mqtt status indicator
        commandBar: ToggleSwitch(
          checked: mqttStatus,
          onChanged: (v) => setState(() => mqttStatus = v),
          content: const Text('Disabled'),
        ),
      ),
      children: const [
        MessageViewer(
          mqttTopic: 'CoilWinder/pi/cw88',
          jsonObject: 'coilnum',
          jsonValue: '0000000000000',
        ),
        Divider(
          direction: Axis.horizontal,
          style: DividerThemeData(
            // verticalMargin: EdgeInsets.all(10),
            horizontalMargin: EdgeInsets.fromLTRB(0, 30, 0, 15),
            thickness: 3,
          ),
        ),
        MessageViewer()
      ],
    );
  }
}
