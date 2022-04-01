// ignore_for_file: unused_import, unused_field, unused_element

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:doc_display/state/mqtt_state.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

class MessageViewer extends StatelessWidget {
  const MessageViewer({Key? key}) : super(key: key);
  // create a counter integer that can be incremented
  final String placeholder = 'count = ';

  static const parsedJson = <String>[
    'item1',
    'item2',
    'item3',
    'item4',
  ];

  // final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MqttAppState _mqttAppState = context.watch<MqttAppState>();
    Typography typography = FluentTheme.of(context).typography;

    var bold = typography.bodyStrong?.apply();
    var subtitle = typography.subtitle?.apply();
    var title = typography.title?.apply();
    var body = typography.body?.apply();
    var caption = typography.caption?.apply();
    // mqttAppState = Provider.of<MqttAppState>(context, listen: false);

    return Card(
      child: TextBox(
        readOnly: false,
        placeholder: placeholder + _mqttAppState.getCounterText,
        outsidePrefix: Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: Text(
              //if message one is null, then show and empty string
              'TOPIC    :',
              style: body,
            )),
        outsideSuffix: Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: IconButton(
            icon: const Icon(FluentIcons.sync),
            onPressed: () {
              _mqttAppState.incrementCounter();
            },
          ),
          // ],
        ),
      ),
    );
  }

  _getItemsFromList(List<String> list) {
    var comboBoxList = list
        .map((e) => ComboboxItem<String>(
              value: e,
              child: Text(e),
            ))
        .toList();

    return comboBoxList;
  }
}

// Removed Widgets

// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// mainAxisSize: MainAxisSize.min,
// children: [
// Expanded(
//     flex: 2,
//     child: InfoLabel(
//         label: 'Objects',
//         child: Combobox<String>(
//             placeholder: const Text('Choose Item'),
//             isExpanded: true,
//             items: _getItemsFromList(parsedJson),
//             value: comboBoxValue,
//             onChanged: (value) {
//               if (value != null) {
//                 setState(() => comboBoxValue = value);
//               }
//             }))),
// const SizedBox(width: 10),
// const Divider(
//   direction: Axis.vertical,
//   size: 50.0,
//   style: DividerThemeData(
//       verticalMargin: EdgeInsets.all(10),
//       horizontalMargin: EdgeInsets.all(10),
//       thickness: 2.0),
// ),
// const SizedBox(width: 10),
