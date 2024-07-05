import 'dart:io';

import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_api/core/constants/hosts.dart';
import 'package:nasa_api/core/providers/debug_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'generated/l10n.dart';
import 'main_module.dart';
import 'core/constants/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  //!Local Database creation
  final Directory pathDir = await getApplicationDocumentsDirectory();
  final String dbPath = join(pathDir.path, localServerUrl);
  DebugProvider.debugLog('Database path = $dbPath');
  // await databaseFactoryIo.deleteDatabase(dbPath);

  final Database db = await databaseFactoryIo.openDatabase(dbPath);
  runApp(
    ModularApp(
      module: AppModule(db: db),
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const NasasPicturesOfTheWeekApp(),
      ),
    ),
  );
}

class NasasPicturesOfTheWeekApp extends StatelessWidget {
  const NasasPicturesOfTheWeekApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('pt', ''), // Portuguese
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorScheme.primary,
          primary: colorScheme.primary,
          secondary: colorScheme.secondary,
        ),
      ),
    );
  }
}
