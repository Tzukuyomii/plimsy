import 'package:plimsy/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:plimsy/util/secure_auth_storage.dart';

class HostService {
  final ApiClient _apiClient = ApiClient(); // Per altri servizi
  Future<Map<String, dynamic>> host(String apikey) async {
    try {
      final token = await SecureAuthStorage.getToken();
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@$apikey");

      if (token != null) {
        print('Token recuperato in modo sicuro: $token');
      } else {
        print('Nessun token salvato.');
      }
      final response = await _apiClient.dio.post(
        "/api/rest-services/v1/hosts/send",
        data: {
          "content": "UHJvdmEgY29udGVudXRv",
          "contentType": "text/plain",
          "hostId": apikey
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Aggiungi il prefisso "Bearer"
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Host richiamato con successo: ${response.data}');
        return response.data;
      } else {
        throw Exception('Errore: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  // Metodo helper per gestire errori di Dio
  Exception _handleDioError(DioError e) {
    if (e.response != null) {
      return Exception(
          'Errore: ${e.response?.data['error_description'] ?? e.message}');
    } else {
      return Exception('Errore di connessione: ${e.message}');
    }
  }
}
