import 'dart:convert';

class Content {
  String request;
  dynamic body;

  Content({required this.request, required this.body});

  // Metodo per convertire l'oggetto Content in una mappa
  Map<String, dynamic> toMap() {
    return {
      'request': request,
      'body': body,
    };
  }

  // Metodo per serializzare l'oggetto Content in una stringa JSON
  String toJson() {
    // Converte la mappa in una stringa JSON
    return json.encode(toMap());
  }

  // Metodo per creare un oggetto Content dalla mappa (deserializzazione)
  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      request: map['request'],
      body: map['body'],
    );
  }
}
