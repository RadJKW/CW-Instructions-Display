// ignore_for_file: unused_import

import 'package:window_manager/window_manager.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import 'package:doc_display/pages/home_page.dart';
import 'package:doc_display/views/browse.dart';
import 'package:doc_display/views/dashboard.dart';
import 'package:doc_display/views/settings.dart';
import 'package:doc_display/views/pdf_view.dart';
import 'package:doc_display/views/vid_player.dart';
import 'package:doc_display/views/mqtt_view.dart';
import 'package:doc_display/common/theme.dart';
import 'package:doc_display/models/app.dart';

const String appTitle = 'Coil Winder Instructions Display';
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
          ChangeNotifierProvider<AppTheme>(create: (_) => AppTheme()),
          ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ],
        builder: (context, _) {
          final appTheme = context.watch<AppTheme>();
          return FluentApp(
            title: appTitle,
            themeMode: appTheme.mode,
            debugShowCheckedModeBanner: false,
            showPerformanceOverlay: false,
            initialRoute: '/',
            routes: {'/': (_) => const MyHomePage(title: appTitle)},
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
        });
  }
}
