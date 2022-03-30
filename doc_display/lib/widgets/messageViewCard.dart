import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

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

    return Card(
      child: TextBox(
          outsidePrefix: Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: Text(
                widget.mqttTopic + '      : ',
                style: typography.bodyStrong?.apply(),
              )),
          outsideSuffix: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: IconButton(
                icon: const Icon(FluentIcons.sync),
                onPressed: () {},
              )),
          placeholder: (widget.jsonObject + ' = ' + widget.jsonValue),
          readOnly: true),
      // ],
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