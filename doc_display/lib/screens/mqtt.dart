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
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: TextBox(
                  header: 'topic - json.object.title',
                  placeholder: 'MQTT info here',
                  readOnly: true,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ],
    );
  }
}
