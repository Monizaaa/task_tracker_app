import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingService extends GetxService {
  final _box = GetStorage();
  final _storageKey = 'app_settings';

  static const String _kPermission = 'permission';
  static const String _kPushNotification = 'pushNotification';
  static const String _kDarkMode = 'isDarkMode';

  final permission = false.obs;
  final pushNotification = true.obs;
  final isDarkMode = false.obs;

  ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    final settings = _box.read<Map<String, dynamic>>(_storageKey) ?? {};
    permission.value = settings[_kPermission] ?? false;
    pushNotification.value = settings[_kPushNotification] ?? false;
    isDarkMode.value = settings[_kDarkMode] ?? Get.isDarkMode;
  }

  Future<void> _saveSettings() async {
    await _box.write(_storageKey, {
      _kPermission: permission.value,
      _kPushNotification: pushNotification.value,
      _kDarkMode: isDarkMode.value,
    });
  }

  void togglePermission() {
    permission.value = !permission.value;
    _saveSettings();
  }

  void togglePushNotification() {
    pushNotification.value = !pushNotification.value;
    _saveSettings();
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(themeMode);
    _saveSettings();
  }
}
