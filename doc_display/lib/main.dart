// ignore_for_file: unused_import

import 'package:window_manager/window_manager.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:doc_display/views/browse.dart';
import 'package:doc_display/views/dashboard.dart';
import 'package:doc_display/views/settings.dart';
import 'package:doc_display/views/pdf_view.dart';
import 'package:doc_display/views/vid_player.dart';
import 'package:doc_display/views/mqtt_view.dart';
import 'package:doc_display/common/theme.dart';
import 'package:doc_display/models/mqtt.dart';
import 'package:doc_display/state/mqtt_state.dart';

const String appTitle = 'Coil Winder Instructions Display';
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          initialRoute: '/',
          routes: {'/': (_) => const MyHomePage()},
          color: appTheme.color,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          theme: ThemeData(
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool value = false;

  final settingsController = ScrollController();

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return ChangeNotifierProvider(
      create: (_) => MqttAppState(),
      builder: (context, _) {
        final mqttAppState = context.watch<MqttAppState>();
        int index = mqttAppState.getCurrentPage;
        return NavigationView(
          appBar: NavigationAppBar(
            title: () {
              return const DragToMoveArea(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(appTitle),
                ),
              );
            }(),
            actions: DragToMoveArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [Spacer()],
              ),
            ),
          ),
          pane: NavigationPane(
            selected: index,
            onChanged: (i) => mqttAppState.setCurrentPage(i),
            // (i) => setState(() => index = i),
            size: const NavigationPaneSize(
              openMinWidth: 250,
              openMaxWidth: 320,
            ),
            header: Container(
              height: kOneLineTileHeight, // kOneLinetileHeight = 40
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: const FlutterLogo(
                style: FlutterLogoStyle.horizontal,
                size: 100,
              ),
            ),
            displayMode: appTheme.displayMode,
            indicatorBuilder: NavigationIndicator.end,
            items: [
              PaneItem(
                  // index 0
                  icon: const Icon(FluentIcons.view_dashboard),
                  title: const Text('    Dashboard')),
              PaneItem(
                  // index 1
                  icon: const Icon(FluentIcons.folder_list),
                  title: const Text('    Browse')),
              PaneItem(
                  // index 2
                  icon: const Icon(FluentIcons.pdf),
                  title: const Text('    PDF Viewer')),
              PaneItem(
                  // index 3
                  icon: const Icon(FluentIcons.photo_video_media),
                  title: const Text('    Videos')),
              PaneItem(
                  // index 4
                  icon: const Icon(FluentIcons.network_tower),
                  title: const Text('    MQTT Test')),
            ],
            footerItems: [
              PaneItemSeparator(),
              PaneItem(
                icon: const Icon(FluentIcons.settings),
                title: const Text('Settings'),
              ),
            ],
          ),
          content: NavigationBody(index: index, children: [
            const Dashboard(), // 0
            const BrowsePage(), // 1
            const PdfPage(), // 2
            const VidplayerPage(), // 3
            const MqttView(), // 4
            SettingsPage(controller: settingsController),
          ]),
        );
      },
    );
  }
}
