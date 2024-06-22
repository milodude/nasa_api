import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_api/main_module.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
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
      title: 'Last week pictures of the day',
      routerConfig: Modular.routerConfig,
      // routeInformationParser: Modular.routeInformationParser,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
