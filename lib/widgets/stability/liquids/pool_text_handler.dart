import 'package:flutter/material.dart';
import 'package:plimsy/models/tank.dart';

class PoolTextHandler extends StatelessWidget {
  final Map<String, List<Tank>> tanks;

  PoolTextHandler({required this.tanks});

  // Funzione per generare la lista dinamica di opzioni (prefisso + id)
  List<String> generateTankOptions() {
    return tanks.entries
        .where((entry) => entry.key == "POOL" || entry.key == "FRESH W.")
        .expand((entry) => entry.value)
        .map((tank) => tank.prefix + " ${tank.id}")
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<String> options = generateTankOptions();

    final String warningPools =
        "WARNING: Swimming Pool to be kept empty during navigation. Use of swimming pool is falling under Master responsibility";

    final String notePools =
        "NOTE: Swimming pool water is deducted from (in case of loading) or added to (in case of discharge) ${options.join(', ')}. No outboard discharge is envisaged in the calculation.";

    return Column(
      children: [
        Text(warningPools,
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.01,
            ),
            textAlign: TextAlign.center),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          notePools,
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.01,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
