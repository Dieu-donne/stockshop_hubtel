import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../network_manager/network_manager.dart';

abstract class BasePrefManager {
  Future<SharedPreferences> get _sharedPreferences async {
    return await SharedPreferences.getInstance();
  }

  void saveToSharedPref(String key, String? value) async {
    SharedPreferences prefs = await _sharedPreferences;
    await prefs.setString(key, value ?? '');
  }

  void saveToSharedPrefBool(String key, bool value) async {
    SharedPreferences prefs = await _sharedPreferences;
    await prefs.setBool(key, value);
  }

  void saveToSharedPrefInt(String key, int value) async {
    SharedPreferences prefs = await _sharedPreferences;
    prefs.setInt(key, value);
  }

  void saveToSharedPrefDouble(String key, double value) async {
    SharedPreferences prefs = await _sharedPreferences;
    prefs.setDouble(key, value);
  }

  Future<String> getSharedPrefString(String key) async {
    SharedPreferences prefs = await _sharedPreferences;
    return prefs.getString(key) ?? '';
  }

  Future<bool> getSharedPrefBool(String key) async {
    SharedPreferences prefs = await _sharedPreferences;
    return prefs.getBool(key) ?? false;
  }

  Future<int> getSharedPrefInt(String key) async {
    SharedPreferences prefs = await _sharedPreferences;
    return prefs.getInt(key) ?? 0;
  }

  Future<double> getSharedPrefDouble(String key) async {
    SharedPreferences prefs = await _sharedPreferences;
    return prefs.getDouble(key) ?? 0.0;
  }

  void saveToSharedPrefStringList({
    required String key,
    required List<String> value,
  }) async {
    SharedPreferences prefs = await _sharedPreferences;
    await prefs.setStringList(key, value);
  }

  Future<List<String>> getSharedPrefStringList({String? key}) async {
    SharedPreferences prefs = await _sharedPreferences;
    return prefs.getStringList(key ?? '') ?? [];
  }

  void saveToSharedPrefObject(String key, Serializable? object) {
    final serializedObject = jsonEncode(object?.toMap());
    saveToSharedPref(key, serializedObject);
  }

  Future<T?> getSharedPrefObject<T>(String key) async {
    final serializedObject = await getSharedPrefString(key);
    if (serializedObject.isNotEmpty) {
      try {
        return jsonDecode(serializedObject);
      } catch (e) {
        log('Error decoding object: $e',
            error: e, name: '$runtimeType', stackTrace: StackTrace.current);
      }
    }
    return null;
  }

  void saveToSharedPrefObjectList(String key, List<Serializable>? objects) {
    final serializedObject =
        (objects ?? []).map((e) => jsonEncode(e.toMap())).toList();
    saveToSharedPrefStringList(key: key, value: serializedObject);
  }

  Future<List<dynamic>?> getSharedPrefObjectList(String key) async {
    final serializedObjects = await getSharedPrefStringList(key: key);
    if (serializedObjects.isNotEmpty) {
      try {
        return serializedObjects.map((e) => jsonDecode(e)).toList();
      } catch (e) {
        log('Error decoding object: $e',
            error: e, name: '$runtimeType', stackTrace: StackTrace.current);
      }
    }
    return null;
  }

  void remove(String key) async {
    SharedPreferences prefs = await _sharedPreferences;
    await prefs.remove(key);
  }

  Future<void> clear() async {
    SharedPreferences prefs = await _sharedPreferences;
    await prefs.clear();
  }
}
