import 'dart:convert';

class FormModel {
  String requestType;
  String email;
  String description;

  FormModel(
      {required this.requestType,
      required this.email,
      required this.description});

  // Metodo per convertire l'oggetto Content in una mappa
  Map<String, dynamic> toMap() {
    return {
      'requestType': requestType,
      'email': email,
      'description': description
    };
  }

  // Metodo per serializzare l'oggetto Content in una stringa JSON
  String toJson() {
    // Converte la mappa in una stringa JSON
    return json.encode(toMap());
  }

  // Metodo per creare un oggetto Content dalla mappa (deserializzazione)
  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      requestType: map['requestType'],
      email: map['email'],
      description: map['description'],
    );
  }
}
