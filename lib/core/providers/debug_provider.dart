import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DebugProvider {
  static void debugLog(String log) async {
    if (kDebugMode) {
      print('[NASA API] - $log');
    }
  }

  static void debugMap(
      String title, String keyName, String valueName, Map map) {
    debugLog('[NASA API] - $title/n');
    map.forEach((key, value) {
      debugLog('$keyName: $key - $valueName: $value');
    });
  }
}
