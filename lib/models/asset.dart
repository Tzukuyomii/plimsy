import 'dart:convert';

class FileObject {
  final String name;

  final String hash;

  // Costruttore
  FileObject({
    required this.name,
    required this.hash,
  });

  // Metodo per creare un oggetto dalla mappa (es. JSON)
  factory FileObject.fromMap(Map<String, dynamic> map) {
    return FileObject(
      name: map['name'] ?? '',
      hash: map['hash'] ?? '',
    );
  }

  // Metodo per convertire l'oggetto in una mappa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'hash': hash,
    };
  }

  // Metodo per serializzare l'oggetto Content in una stringa JSON
  String toJson() {
    // Converte la mappa in una stringa JSON
    return json.encode(toMap());
  }
}
