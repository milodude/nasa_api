import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nasa_api/generated/l10n.dart';

class WidgetSetupToBeTested extends StatelessWidget {
  const WidgetSetupToBeTested({
    super.key,
    required this.child,
    this.intl = 'pt',
    this.locale = 'BR',
  });
  final Widget child;
  final String intl;
  final String locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        Locale(intl, locale),
      ],
      home: Scaffold(body: child),
    );
  }
}
