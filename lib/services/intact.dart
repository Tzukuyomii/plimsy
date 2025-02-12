import 'dart:convert';

import 'package:plimsy/models/content.dart';
import 'package:plimsy/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:plimsy/services/handler_error.dart';

class Intact {
  final ApiClient _apiClient = ApiClient(); // Per altri servizi

  Future<Map<String, dynamic>> stability(String apikey, Content content) async {
    try {
      final response = await _apiClient.dio.post(
        "/api/rest-services/v1/hosts/send",
        data: {
          "content": content,
          "contentType": "text/plain",
          "hostId": apikey
        },
      );

      if (response.statusCode == 200) {
        print('Intact completato con successo: ${response.data}');
        final responseData = json.decode(response.data["content"]);

        return responseData["res"]["data"];
      } else {
        throw Exception('Errore: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw handleDioError(e);
    }
  }
}
