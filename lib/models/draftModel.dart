import 'package:plimsy/models/tank.dart';

class DraftModel {
  final Map<String, List<Tank>> tanks;
  final List<Tank> pools;
  final List<dynamic> fixedWeightTableData;
  final double totalDisplacement;
  final double seaWaterDensity;

  DraftModel({
    required this.tanks,
    required this.pools,
    required this.fixedWeightTableData,
    required this.totalDisplacement,
    required this.seaWaterDensity,
  });

  // Factory per la deserializzazione da JSON
  factory DraftModel.fromJson(Map<String, dynamic> json) {
    return DraftModel(
      tanks: json['tanks'] as Map<String, List<Tank>>,
      pools: json['pools'] as List<Tank>,
      fixedWeightTableData: List<dynamic>.from(
          json['fixedWeightTableData'] ?? []), // Valore di default
      totalDisplacement: (json['totalDisplacement'] as num).toDouble(),
      seaWaterDensity: (json['seaWaterDensity'] as num).toDouble(),
    );
  }

  // Metodo per convertire DraftModel in JSON
  Map<String, dynamic> toJson() {
    // Converti la mappa `tanks` in un formato JSON-friendly
    final tanksJson = tanks.map((key, value) {
      return MapEntry(key, value.map((tank) => tank.toJson()).toList());
    });

    return {
      'tanks': tanksJson,
      'pools': pools.map((pool) => pool.toJson()).toList(),
      'fixedWeightTableData': fixedWeightTableData,
      'totalDisplacement': totalDisplacement,
      'seaWaterDensity': seaWaterDensity,
    };
  }
}
