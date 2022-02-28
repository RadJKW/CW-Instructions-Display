import 'package:fluent_ui/fluent_ui.dart';


class VidplayerPage extends StatelessWidget {
  const VidplayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Divider(
      style: DividerThemeData(
        verticalMargin: EdgeInsets.all(10),
        horizontalMargin: EdgeInsets.all(10),
      ),
    );
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('vidplayer.dart screen')),
      bottomBar: const InfoBar(
        title: Text('Tip:'),
        content: Text(
          'You can click on any color to copy it to the clipboard!',
        ),
      ),
      children: const [],
    );
  }
}
