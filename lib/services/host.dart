import 'dart:convert';

import 'package:plimsy/models/content.dart';
import 'package:plimsy/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:plimsy/services/handler_error.dart';
import 'package:plimsy/util/folder_create.dart';
import 'package:plimsy/util/secure_auth_storage.dart';

class HostService {
  final ApiClient _apiClient = ApiClient(); // Per altri servizi

  Future<Map<String, dynamic>> host(String apikey, Content content) async {
    try {
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  $apikey");
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  BODY  ${content.body}");

      final response = await _apiClient.dio.post(
        "/api/rest-services/v1/hosts/send",
        data: {
          "content": content,
          "contentType": "text/plain",
          "hostId": apikey
        },
      );

      if (response.statusCode == 200) {
        print('Host richiamato con successo: ${response.data}');
        final responseData = json.decode(response.data["content"]);

        if (await response.data["content"] != null) {
          if (responseData["res"] != null &&
              responseData["res"]["assets"] != null) {
            processAssets(responseData["res"]["assets"]);
            SecureAuthStorage.saveAssetsToSecureStorage(
                responseData["res"]["assets"]);
            print("SALVATO");
          }
        } else {
          print("La chiave 'content' è nulla nella risposta.");
        }

        print("ASSETS STORAGE ${await SecureAuthStorage.getAssets()}");

        return jsonDecode(responseData["res"]["data"]);
      } else {
        throw Exception('Errore: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw handleDioError(e);
    }
  }
}
