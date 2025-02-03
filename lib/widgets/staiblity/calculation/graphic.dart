import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graphic extends StatelessWidget {
  final List<dynamic>? frames;
  final List<dynamic>? shearDataSet;
  final List<dynamic>? momentDataSet;

  Graphic({
    super.key,
    required this.frames,
    required this.shearDataSet,
    required this.momentDataSet,
  });

  double minX = 0;
  double maxX = 50;
  double minY = 0;
  double maxY = 300;

  @override
  Widget build(BuildContext context) {
    // Convertiamo le liste di mappe in liste di FlSpot
    List<FlSpot> shearSpots = _generateSpotsFromMap(shearDataSet ?? []);
    List<FlSpot> momentSpots = _generateSpotsFromMap(momentDataSet ?? []);

    // Calcoliamo i valori reali per minX, maxX, minY e maxY
    if (shearSpots.isNotEmpty && momentSpots.isNotEmpty) {
      minX = _findMinX(frames ?? [], shearSpots, momentSpots);
      maxX = _findMaxX(frames ?? [], shearSpots, momentSpots);
      minY = _findMinY(shearSpots, momentSpots);
      maxY = _findMaxY(shearSpots, momentSpots);
    }

    return AspectRatio(
      aspectRatio: 2.0,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles:
                  SideTitles(showTitles: false), // Rimuovi la linea sopra
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 50,
                showTitles: true,
                reservedSize: 30, // Spazio per i numeri
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(1), // Mostra 1 decimale
                    style: TextStyle(fontSize: 8), // Font più piccolo
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 50,
                showTitles: true,
                reservedSize: 30, // Spazio per i numeri
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(1), // Mostra 1 decimale
                    style: TextStyle(fontSize: 8), // Font più piccolo
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5, // Mostra etichette ogni 5 unità
                reservedSize: 20, // Spazio per i numeri
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0), // Mostra solo numeri interi
                    style: TextStyle(fontSize: 8), // Font più piccolo
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          lineBarsData: [
            LineChartBarData(
              spots: shearSpots,
              isCurved: true,
              color: Colors.blue,
              dotData: FlDotData(show: false),
            ),
            LineChartBarData(
              spots: momentSpots,
              isCurved: true,
              color: Colors.red,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  /// Funzione che estrae i valori x e y dalle mappe e li converte in FlSpot
  List<FlSpot> _generateSpotsFromMap(List<dynamic> dataset) {
    List<FlSpot> spots = [];

    for (var item in dataset) {
      if (item is Map<String, dynamic>) {
        double? x = _toDouble(item["x"]);
        double? y = _toDouble(item["y"]);

        if (x != null && y != null) {
          spots.add(FlSpot(x, y));
        }
      }
    }

    // Ordiniamo i punti per X (assicurato che l'asse X sia crescente)
    spots.sort((a, b) => a.x.compareTo(b.x));

    return spots;
  }

  /// Converte qualsiasi valore in double (int, double, String)
  double? _toDouble(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null; // Se non è convertibile, restituisce null
  }

  /// Trova il minimo valore di X tra frames, shearDataSet e momentDataSet
  double _findMinX(
      List<dynamic> frames, List<FlSpot> shearSpots, List<FlSpot> momentSpots) {
    List<double> xValues = [];

    if (frames.isNotEmpty) {
      xValues.addAll(frames.map((e) => _toDouble(e) ?? double.infinity));
    }

    if (shearSpots.isNotEmpty) {
      xValues.addAll(shearSpots.map((spot) => spot.x));
    }

    if (momentSpots.isNotEmpty) {
      xValues.addAll(momentSpots.map((spot) => spot.x));
    }

    return xValues.reduce((a, b) => a < b ? a : b);
  }

  /// Trova il massimo valore di X tra frames, shearDataSet e momentDataSet
  double _findMaxX(
      List<dynamic> frames, List<FlSpot> shearSpots, List<FlSpot> momentSpots) {
    List<double> xValues = [];

    if (frames.isNotEmpty) {
      xValues
          .addAll(frames.map((e) => _toDouble(e) ?? double.negativeInfinity));
    }

    if (shearSpots.isNotEmpty) {
      xValues.addAll(shearSpots.map((spot) => spot.x));
    }

    if (momentSpots.isNotEmpty) {
      xValues.addAll(momentSpots.map((spot) => spot.x));
    }

    return xValues.reduce((a, b) => a > b ? a : b);
  }

  /// Trova il minimo valore di Y tra shearDataSet e momentDataSet
  double _findMinY(List<FlSpot> shearSpots, List<FlSpot> momentSpots) {
    List<double> yValues = [];

    if (shearSpots.isNotEmpty) {
      yValues.addAll(shearSpots.map((spot) => spot.y));
    }

    if (momentSpots.isNotEmpty) {
      yValues.addAll(momentSpots.map((spot) => spot.y));
    }

    return yValues.reduce((a, b) => a < b ? a : b);
  }

  /// Trova il massimo valore di Y tra shearDataSet e momentDataSet
  double _findMaxY(List<FlSpot> shearSpots, List<FlSpot> momentSpots) {
    List<double> yValues = [];

    if (shearSpots.isNotEmpty) {
      yValues.addAll(shearSpots.map((spot) => spot.y));
    }

    if (momentSpots.isNotEmpty) {
      yValues.addAll(momentSpots.map((spot) => spot.y));
    }

    return yValues.reduce((a, b) => a > b ? a : b);
  }
}
