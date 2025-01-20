import 'package:dio/dio.dart';
import 'package:plimsy/util/secure_auth_storage.dart';
import 'package:plimsy/services/auth_service.dart'; // Aggiungi AuthService per il refresh token

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(BaseOptions(
          baseUrl: "https://license.askmesuite.com/archimedemarine",
          connectTimeout: const Duration(seconds: 120),
          receiveTimeout: const Duration(seconds: 120),
        )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Ottieni il token attuale (access token)
        String? token = await SecureAuthStorage.getToken();

        // Se il token è presente, aggiungilo all'header della richiesta
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        // Se l'errore è un 401 (Unauthorized), prova a fare il refresh del token
        if (error.response?.statusCode == 401) {
          final refreshToken = await SecureAuthStorage.getRefreshToken();

          if (refreshToken != null) {
            try {
              // Chiamata al metodo di refresh token
              await _refreshAccessToken(refreshToken);

              // Dopo aver aggiornato il token, riprova la richiesta originale
              final newToken = await SecureAuthStorage.getToken();
              if (newToken != null) {
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newToken';
                final clonedRequest = await dio.fetch(error.requestOptions);
                return handler.resolve(clonedRequest);
              }
            } catch (e) {
              // Se il refresh token fallisce, gestisci l'errore, es. logout
              return handler.reject(error);
            }
          }
        }
        return handler.next(error);
      },
    ));
  }

  // Metodo per fare il refresh del token utilizzando il refresh token
  Future<void> _refreshAccessToken(String refreshToken) async {
    final authService = AuthService(); // Istanza del servizio di autenticazione
    await authService.refreshAccessToken(refreshToken);
  }
}
