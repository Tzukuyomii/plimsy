import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureAuthStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  static Future<void> clearStorage() async {
    await _storage.deleteAll();
  }

  static void saveAssetsToSecureStorage(String jsonString) async {
    try {
      // Decodifica gli asset ricevuti dal server
      final List<dynamic> newAssets = json.decode(jsonString);

      // Recupera gli asset già salvati nel Secure Storage
      final String? existingAssetsJson = await _storage.read(key: 'assets');
      Map<String, String> existingAssets = {};

      if (existingAssetsJson != null) {
        // Decodifica gli asset esistenti se presenti
        existingAssets =
            Map<String, String>.from(json.decode(existingAssetsJson));
      }

      // Aggiorna gli asset esistenti con quelli ricevuti dal server
      for (var newAsset in newAssets) {
        final String name = newAsset['name'];
        final String hash = newAsset['hash'];

        // Aggiorna o aggiungi l'asset nella mappa
        existingAssets[name] = hash;
        print("Asset aggiornato o aggiunto: $name -> $hash");
      }

      // Salva la mappa aggiornata nel Secure Storage come stringa JSON
      final String encodedAssets = json.encode(existingAssets);
      await _storage.write(key: 'assets', value: encodedAssets);

      print('Assets aggiornati e salvati in modo sicuro!');
    } catch (e) {
      print('Errore durante il salvataggio degli assets: $e');
      throw Exception(e);
    }
  }

  static Future<String?> getAssets() async {
    try {
      return await _storage.read(key: "assets");
    } catch (e) {
      print("Errore nel recupero degli assets: $e");
      return null;
    }
  }
}
