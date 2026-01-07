import 'package:mvp_shared_components/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBoolean(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> writeString({required String key, required value}) async {
    return await _prefs.setString(key, value);
  }

  Future<String?> read({required String key}) async {
    return _prefs.getString(key);
  }

  bool isLoggedIn() {
    return _prefs.getBool(STORAGE_IS_LOGGED_IN) ?? false;
  }

  Future<bool> clearAll() async {
    try {
      Set<String> keys = _prefs.getKeys();

      for (String key in keys) {
        await _prefs.remove(key);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
