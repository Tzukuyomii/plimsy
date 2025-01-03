import 'package:dio/dio.dart';

Exception handleDioError(DioError e) {
  // Controlla se la risposta esiste e contiene dati
  if (e.response != null && e.response?.data != null) {
    try {
      // Verifica che `data` sia un `Map` per accedere in sicurezza
      if (e.response?.data is Map<String, dynamic>) {
        final errorDescription = e.response?.data['error_description'] ??
            'Errore sconosciuto dal server';
        return Exception('Errore dalla risposta del server: $errorDescription');
      } else if (e.response?.data is String) {
        // Se è una stringa, restituisci direttamente
        return Exception('Errore dal server: ${e.response?.data}');
      } else {
        // Caso generico per tipi inaspettati
        return Exception(
            'Errore sconosciuto dalla risposta del server: ${e.response?.data.toString()}');
      }
    } catch (ex) {
      // Catch di fallback per errori inaspettati durante l'elaborazione della risposta
      return Exception(
          'Errore durante l\'analisi della risposta: ${ex.toString()}');
    }
  } else {
    // Caso di errore senza risposta o problema di connessione
    return Exception('Errore di connessione: ${e.message}');
  }
}
