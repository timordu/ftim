import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  SpUtil._();

  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  ///获取bool
  static Future<bool> getBool(String key, bool defaultValue) {
    return _getPreferences().then((sp) => sp.getBool(key) ?? defaultValue);
  }

  ///保存bool
  static void setBool(String key, bool value) {
    _getPreferences().then((sp) {
      sp.setBool(key, value);
    });
  }

  ///获取String
  static Future<String> getString(String key, String defaultValue) {
    return _getPreferences().then((sp) => sp.getString(key) ?? defaultValue);
  }

  ///保存String
  static void setString(String key, String value) {
    _getPreferences().then((sp) {
      sp.setString(key, value);
    });
  }

  ///获取List<String>
  static Future<List<String>> getListString(String key) {
    return _getPreferences().then((sp) => sp.getStringList(key) ?? []);
  }

  ///保存List<String>
  static void setListString(String key, List<String> value) {
    _getPreferences().then((sp) {
      sp.setStringList(key, value);
    });
  }

  ///获取Double
  static Future<double> getDouble(String key, double defaultValue) {
    return _getPreferences().then((sp) => sp.getDouble(key) ?? defaultValue);
  }

  ///保存Double
  static void setDouble(String key, double value) {
    _getPreferences().then((sp) {
      sp.setDouble(key, value);
    });
  }

  ///获取Int
  static Future<int> getInt(String key, int defaultValue) {
    return _getPreferences().then((sp) => sp.getInt(key) ?? defaultValue);
  }

  ///保存Int
  static void setInt(String key, int value) {
    _getPreferences().then((sp) {
      sp.setInt(key, value);
    });
  }

  ///移除key
  static Future<bool> remove(String key) {
    return _getPreferences().then((sp) => sp.remove(key));
  }

  ///判断是否包含key
  static Future<bool> contains(String key) {
    return _getPreferences().then((sp) => sp.containsKey(key));
  }
}
