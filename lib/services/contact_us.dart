import 'dart:convert';

import 'package:plimsy/models/content.dart';
import 'package:plimsy/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:plimsy/services/handler_error.dart';

class ContactUs {
  final ApiClient _apiClient = ApiClient();
  Future<Map<String, dynamic>> contactUs(String apikey, Content content) async {
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
        print('RESPONSE CONTACT US: ${response.data["res"]}');

        return jsonDecode(response.data["content"]);
      } else {
        throw Exception('Errore: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw handleDioError(e);
    }
  }
}
