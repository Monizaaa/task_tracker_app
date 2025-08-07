import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_tracker_app/core/services/auth_service.dart';

class ApiClient extends GetxService {
  late final http.Client _client;
  // Use Get.find to get the instance of AuthService
  final AuthService _authService = Get.find<AuthService>();

  final String baseUrl = "http://YOUR_LOCAL_IP:3000/api";

  Map<String, String> get defaultHeaders {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_authService.isLoggedIn.value) {
      headers['Authorization'] = 'Bearer ${_authService.token}';
    }
    return headers;
  }

  http.Client get client => _client;

  @override
  void onInit() {
    super.onInit();
    _client = http.Client();
  }
}
