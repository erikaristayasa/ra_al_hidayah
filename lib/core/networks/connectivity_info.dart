part of 'networks.dart';

abstract class ConnectivityInfo {
  Future<bool> get isConnected;
}

class ConnectivityInfoImplementation implements ConnectivityInfo {
  final Connectivity connectivity;

  ConnectivityInfoImplementation({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return Future.value(false);
    }
    return Future.value(true);
  }
}
