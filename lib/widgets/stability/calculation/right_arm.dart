import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RightArm extends StatefulWidget {
  RightArm({super.key, required this.intactData});

  Map<String, dynamic> intactData;
  @override
  State<StatefulWidget> createState() {
    return _RightArm();
  }
}

class _RightArm extends State<RightArm> {
  List<FlSpot> mapToFlSpots(List<dynamic> dataset) {
    return dataset.map((data) {
      // Estrai i valori x e y dal dataset e convertili in double
      double x = data['x']?.toDouble() ??
          0.0; // Se non esiste, usa 0.0 come valore di fallback
      double y = data['y']?.toDouble() ??
          0.0; // Se non esiste, usa 0.0 come valore di fallback
      return FlSpot(x, y); // Crea un FlSpot per ogni coppia di coordinate
    }).toList(); // Restituisci una lista di FlSpot
  }

  List<FlSpot> mapToFlSpotsClamped(
      List<dynamic> dataset, double minY, double maxY) {
    return dataset.map((data) {
      double x = data['x']?.toDouble() ?? 0.0;
      double y = data['y']?.toDouble() ?? 0.0;

      // Limita y entro minY e maxY
      y = y.clamp(minY, maxY);

      return FlSpot(x, y);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final intactDataAvailable = widget.intactData.isNotEmpty;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double minX = intactDataAvailable
        ? widget.intactData["gzChart"]["sortChartLabel"].first.toDouble()
        : 0.0;
    double maxX = intactDataAvailable
        ? widget.intactData["gzChart"]["sortChartLabel"].last.toDouble()
        : 70.0;

    double minY = intactDataAvailable
        ? widget.intactData["gzChart"]["minYdp"].toDouble()
        : -1;
    double maxY = intactDataAvailable
        ? widget.intactData["gzChart"]["maxYdp"].toDouble()
        : 1;

    return Column(
      children: [
        Row(
          children: [
            RotatedBox(
              quarterTurns:
                  3, // -90 gradi rispetto a Est (3 x 90° = 270° in senso antiorario)
              child: Text(
                "GZ(m)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.007,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: width * 0.0015,
            ),
            SizedBox(
              width: width * 0.25,
              height: height * 0.2,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: false), // Rimuovi la linea sopra
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: false), // Rimuovi la linea sopra
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        interval: 0.2,
                        showTitles: true,
                        reservedSize: 20, // Spazio per i numeri
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(1), // Mostra 1 decimale
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.007,
                            ), // Font più piccolo
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10, // Mostra etichette ogni 5 unità
                        reservedSize: 15, // Spazio per i numeri
                        getTitlesWidget: (value, meta) {
                          return Text(
                            "${value.toStringAsFixed(0)}°", // Mostra solo numeri interi
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.007,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true, // Mostra il bordo
                    border: const Border(
                      top: BorderSide(
                          color: Colors.transparent,
                          width: 0), // Nasconde il bordo superiore
                      right: BorderSide(
                          color: Colors.transparent,
                          width: 0), // Nasconde il bordo destro
                      bottom: BorderSide(
                          color: Colors.white,
                          width: 1), // Bordo bianco in basso
                      left: BorderSide(
                          color: Colors.white,
                          width: 1), // Bordo bianco a sinistra
                    ),
                  ),
                  minX: minX,
                  maxX: maxX,
                  minY: minY,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: intactDataAvailable
                          ? mapToFlSpots(
                              widget.intactData["gzChart"]["firstDataset"])
                          : [FlSpot(0, 0)],
                      isCurved: true,
                      color: Colors.blue,
                      dotData: const FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: intactDataAvailable
                          ? mapToFlSpotsClamped(
                              widget.intactData["gzChart"]["secondDataset"],
                              minY,
                              maxY)
                          : [FlSpot(0, 0)],
                      isCurved: true,
                      color: Colors.red,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "${intactDataAvailable ? widget.intactData["gzChart"]["xLabelTitle"] : "-"} (°)",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.007,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  color: Colors.red,
                  width: width * 0.02,
                  height: height * 0.015,
                ),
                SizedBox(
                  width: width * 0.003,
                ),
                Text(
                  "DOWNFLOODING POINT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.0099,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: height * 0.015,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "DOWNFLOODING POINT: ${intactDataAvailable ? widget.intactData["gzChart"]["dpInfo"]["description"] : ""}",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.0099,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "HEEL:   ${intactDataAvailable ? widget.intactData["gzChart"]["dpInfo"]["grades"] : "0.00"}°",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.0099,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "GZ:  ${intactDataAvailable ? widget.intactData["gzChart"]["dpInfo"]["gz"] : "0.00"}m",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.0099,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
