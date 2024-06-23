import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ConnectivityProvider {
  ConnectivityProvider({required this.client}) {
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    checkInitialConnection();
    _startPeriodicInternetCheck();
  }

  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();
  late Connectivity _connectivity;
  final http.Client client;

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  Future<void> checkInitialConnection() async {
    final status = await _connectivity.checkConnectivity();
    _updateConnectionStatus(status);
  }

  void _startPeriodicInternetCheck() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool isConnected = await _hasInternetConnection();
      _connectionStatusController.add(isConnected);
    });
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    await Future.delayed(const Duration(milliseconds: 200));
    bool isConnected = await _hasInternetConnection();
    _connectionStatusController.add(isConnected);
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final response = await client
          .get(Uri.parse('https://google.com'))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
