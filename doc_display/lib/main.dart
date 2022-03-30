// ignore_for_file: unused_import

import 'package:window_manager/window_manager.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'screens/browse.dart';
import 'screens/dashboard.dart';
import 'screens/settings.dart';
import 'screens/pdf_view.dart';
import 'screens/vid_player.dart';
import 'screens/mqtt_view.dart';
import 'theme.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppTheme(),
        ),
        // Provider(AppStateService.instance
        //     create: (_) => MQTTManager(
        //         host: host, topic: topic, identifier: identifier, state: state))
      ],
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
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
          builder: (context, child) {
            return Directionality(
              textDirection: appTheme.textDirection,
              child: child!,
            );
          },
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

  int index = 4;

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
    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          if (kIsWeb) return const Text(appTitle);
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appTitle),
            ),
          );
        }(),
        actions: kIsWeb
            ? null
            : DragToMoveArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [Spacer()],
                ),
              ),
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        displayMode: appTheme.displayMode,
        indicatorBuilder: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return NavigationIndicator.end;
            case NavigationIndicators.sticky:
            default:
              return NavigationIndicator.sticky;
          }
        }(),
        items: [
          // TODO: Instead of populating these manually,
          //  use a list or map type thing.
          PaneItem(
            // index 0 - dashboard.dart
            icon: const Icon(FluentIcons.view_dashboard),
            title: const Text('    Dashboard'),
          ),
          PaneItem(
            // index 1 - browse.dart
            icon: const Icon(FluentIcons.folder_list),
            title: const Text('    Browse'),
          ),
          PaneItem(
            // index 2
            icon: const Icon(FluentIcons.pdf),
            title: const Text('    PDF Viewer'),
          ),
          PaneItem(
            // index 3
            icon: const Icon(FluentIcons.photo_video_media),
            title: const Text('    Videos'),
          ),
          PaneItem(
            // index 4
            icon: const Icon(FluentIcons.photo_video_media),
            title: const Text('    MQTT Test'),
          ),
        ],
        autoSuggestBox: AutoSuggestBox(
          controller: TextEditingController(),
          items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
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
  }
}
