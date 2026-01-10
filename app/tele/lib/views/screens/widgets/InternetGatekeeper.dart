import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetController extends GetxController {
  late final InternetConnectionChecker _connectionChecker;
  RxBool hasInternet = true.obs;
  RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _connectionChecker = InternetConnectionChecker.createInstance();
    _checkInitialConnection();

    _connectionChecker.onStatusChange.listen((status) {
      final isConnected = status == InternetConnectionStatus.connected;
      hasInternet.value = isConnected;
    });
  }

  Future<void> _checkInitialConnection() async {
    final isConnected = await _connectionChecker.hasConnection;
    hasInternet.value = isConnected;
    isInitialized.value = true;
  }
}
