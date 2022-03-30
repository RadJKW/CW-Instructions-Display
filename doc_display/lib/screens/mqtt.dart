// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

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

  // global variables go here

  // variables that cause the view to be reloaded
  //    due to the provider
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
            verticalMargin: EdgeInsets.all(10),
            horizontalMargin: EdgeInsets.all(10),
            thickness: 3,
          ),
        ),
        MessageViewer()
      ],
    );
  }
}

class MessageViewer extends StatefulWidget {
  final String mqttTopic;
  final String jsonObject;
  final String jsonValue;

  const MessageViewer({
    Key? key,
    this.mqttTopic = 'Topic',
    this.jsonObject = 'Object',
    this.jsonValue = 'Value',
  }) : super(key: key);

  @override
  State<MessageViewer> createState() => _MessageViewerState();
}

class _MessageViewerState extends State<MessageViewer> {
  static const parsedJson = <String>[
    'item1',
    'item2',
    'item3',
    'item4',
  ];
  String? comboBoxValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            flex: 2,
            child: InfoLabel(
              label: 'Objects',
              child: Combobox<String>(
                placeholder: const Text('Choose Item'),
                isExpanded: true,
                items:
                    // parsedJson will be the list of app objects within the jsonString
                    parsedJson
                        .map((e) => ComboboxItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                value: comboBoxValue,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => comboBoxValue = value);
                    // setState will update the textBox 'placeholder text' with json value
                  }
                },
              ),
            )),
        const SizedBox(
          width: 10,
        ),
        const Divider(
          direction: Axis.vertical,
          size: 50.0,
          style: DividerThemeData(
            verticalMargin: EdgeInsets.all(10),
            horizontalMargin: EdgeInsets.all(10),
            thickness: 2.0,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: TextBox(
            outsideSuffix: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 2,
                ),
                child: Button(
                  child: const Text('done'),
                  onPressed: () {},
                )),
            header: widget.mqttTopic,
            // headerStyle: typography.subtitle?.apply(),
            placeholder: (widget.jsonObject + ' = ' + widget.jsonValue),
            readOnly: true,
            // style: typography.title?.apply(),
          ),
        ),
      ],
    );
  }
}
