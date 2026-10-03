import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheHelper {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static late final FlutterSecureStorage storage;

  static init() async {
    storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  static dynamic getData({
    required String key,
  }) async {
    return await storage.read(key: key);
  }

  static Future<void> saveData(
      {required String key, required String? value}) async {
    await storage.write(key: key, value: value);
  }

  static Future<void> removeData({required String key}) async {
    await storage.delete(key: key);
  }

  static Future<void> clear() async {
    await storage.deleteAll();
  }
}
