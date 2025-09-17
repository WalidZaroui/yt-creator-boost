import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController {
  NetworkController() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  final Connectivity _connectivity = Connectivity();
  void Function(bool isConnected)? onConnectionChanged;

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isConnected = !results.contains(ConnectivityResult.none);
    onConnectionChanged?.call(isConnected);
  }

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
}