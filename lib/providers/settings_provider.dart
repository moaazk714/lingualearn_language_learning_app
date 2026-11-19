import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';

class SettingsProvider with ChangeNotifier {
  final StorageService _storageService;

  late bool _isDarkMode;
  late bool _isSoundEnabled;
  late bool _areNotificationsEnabled;
  late String _userName;

  SettingsProvider(this._storageService) {
    _init();
  }

  void _init() {
    _isDarkMode = _storageService.isDarkMode();
    _isSoundEnabled = _storageService.isSoundEnabled();
    _areNotificationsEnabled = _storageService.areNotificationsEnabled();
    _userName = _storageService.getUserName();
  }

  bool get isDarkMode => _isDarkMode;
  bool get isSoundEnabled => _isSoundEnabled;
  bool get areNotificationsEnabled => _areNotificationsEnabled;
  String get userName => _userName;

  Future<void> toggleDarkMode(bool isDark) async {
    if (_isDarkMode == isDark) return;
    final previous = _isDarkMode;
    _isDarkMode = isDark;
    notifyListeners();
    if (!await _storageService.setDarkMode(isDark)) {
      _isDarkMode = previous;
      notifyListeners();
      throw StateError('Unable to persist the theme setting.');
    }
  }

  Future<void> toggleSound(bool enabled) async {
    if (_isSoundEnabled == enabled) return;
    _isSoundEnabled = enabled;
    await _storageService.setSoundEnabled(enabled);
    notifyListeners();
  }

  Future<void> toggleNotifications(bool enabled) async {
    if (_areNotificationsEnabled == enabled) return;
    _areNotificationsEnabled = enabled;
    await _storageService.setNotificationsEnabled(enabled);
    notifyListeners();
  }

  Future<void> updateUserName(String name) async {
    if (_userName == name) return;
    _userName = name;
    await _storageService.setUserName(name);
    notifyListeners();
  }

  Future<void> resetAll() async {
    await _storageService.clearAllData();
    _init();
    notifyListeners();
  }
}
