import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graphic extends StatefulWidget {
  const Graphic({super.key});

  @override
  State<Graphic> createState() {
    return _Graphic();
  }
}

class _Graphic extends State<Graphic> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.0,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 0),
                FlSpot(1, 1),
                FlSpot(2, 1),
                FlSpot(3, 4),
                FlSpot(4, 5),
                FlSpot(5, 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
