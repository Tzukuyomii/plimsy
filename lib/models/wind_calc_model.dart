class WindCalcModel {
  final double force; // Velocità del vento in nodi
  final double degrees; // Angolazione del vento in gradi

  // Costruttore
  WindCalcModel({required this.force, required this.degrees});

  // Metodo per convertire l'oggetto in una mappa
  Map<String, dynamic> toJson() {
    return {
      'force': force,
      'degrees': degrees,
    };
  }

  // Metodo per creare l'oggetto dalla mappa (per quando ricevi i dati)
  factory WindCalcModel.fromJson(Map<String, dynamic> json) {
    return WindCalcModel(
      force: json['force'].toDouble(),
      degrees: json['degrees'].toDouble(),
    );
  }
}
