import 'package:dio/dio.dart';
import 'package:plimsy/dto/user.dart';
import 'package:plimsy/services/api_client.dart';
import 'package:plimsy/util/secure_auth_storage.dart';

class AuthService {
  final Dio _dio = Dio(); // Per il token
  final ApiClient _apiClient = ApiClient(); // Per altri servizi
  final String _tokenEndpoint =
      'https://account.askmesuite.com/realms/askmesuite/protocol/openid-connect/token';
  final String _clientId = 'license-server-archimedemarine-users';

  // Metodo per ottenere il token
  Future<Map<String, dynamic>> getToken(
      String username, String password) async {
    try {
      final response = await _dio.post(
        _tokenEndpoint,
        data: {
          'grant_type': 'password',
          'client_id': _clientId,
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${response.data["refresh_token"]}");

      if (response.statusCode == 200) {
        final tokenData = response.data;
        await SecureAuthStorage.saveToken(tokenData['access_token']);
        await SecureAuthStorage.saveRefreshToken(tokenData['refresh_token']);
        return tokenData;
      } else {
        throw Exception(
            'Errore nel recupero del token: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> refreshAccessToken() async {
    final refreshToken = await SecureAuthStorage.getRefreshToken();

    if (refreshToken == null) {
      throw Exception('Refresh token mancante. Effettua nuovamente il login.');
    }

    final response = await _dio.post(
      _tokenEndpoint,
      data: {
        'grant_type': 'refresh_token',
        'client_id': _clientId,
        'refresh_token': refreshToken,
      },
      options: Options(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      // Aggiorna i token nello storage
      await SecureAuthStorage.saveToken(newAccessToken);
      if (newRefreshToken != null) {
        await SecureAuthStorage.saveRefreshToken(newRefreshToken);
      }
    } else {
      throw Exception('Errore nel refresh del token: ${response.statusCode}');
    }
  }

  // Metodo per fare il login con il token ottenuto
  Future<UserDTO> login() async {
    try {
      final token = await SecureAuthStorage.getToken();
      if (token != null) {
        print('Token recuperato in modo sicuro: $token');
      } else {
        print('Nessun token salvato.');
      }

      final response = await _apiClient.dio.post(
        "/api/rest-services/v1/users/login",
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Aggiungi il prefisso "Bearer"
            "Content-Type": "application/json",
          },
        ),
      );
      // print("USER JSON${UserDTO.fromJson(response.data)}");

      if (response.statusCode == 200) {
        print('Login avvenuto con successo: ${response.data}');
        return UserDTO.fromJson(response.data);
      } else {
        throw Exception('Errore nel login: ${response.statusCode}');
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

  // Metodo combinato per ottenere token e fare login
  Future<UserDTO> authenticate(String username, String password) async {
    final tokenData = await getToken(username, password);

    return await login(); // Passa il token al secondo servizio
  }
}
