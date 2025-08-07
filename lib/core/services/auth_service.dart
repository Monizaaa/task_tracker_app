import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// A service to manage authentication state and token persistence.
class AuthService extends GetxService {
  final GetStorage _box = GetStorage();
  static const _tokenKey = 'auth_token';

  final _token = Rx<String?>(null);

  /// A reactive boolean to check if the user is logged in.
  /// The UI can react to changes in this value.
  final isLoggedIn = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    _loadTokenFromStorage();
  }

  /// Loads the token from local storage when the service is initialized.
  void _loadTokenFromStorage() {
    final storedToken = _box.read<String?>(_tokenKey);
    if (storedToken != null && storedToken.isNotEmpty) {
      _token.value = storedToken;
      isLoggedIn.value = true;
    }
  }

  /// The current authentication token. Null if not logged in.
  String? get token => _token.value;

  /// Saves the token to local storage and updates the authentication state.
  Future<void> saveToken(String newToken) async {
    _token.value = newToken;
    isLoggedIn.value = true;
    await _box.write(_tokenKey, newToken);
  }

  /// Clears the token from local storage and updates the authentication state.
  Future<void> clearToken() async {
    _token.value = null;
    isLoggedIn.value = false;
    await _box.remove(_tokenKey);
  }
}
