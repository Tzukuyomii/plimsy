import 'package:flutter/material.dart';
import 'package:plimsy/models/tank.dart';

class LiquidsOnBoardContainer extends StatefulWidget {
  LiquidsOnBoardContainer({
    super.key,
    required this.tanksData,
    required this.selectColor,
    required this.percentageNotifier,
  });

  final Map<String, List<Tank>> tanksData; // Dati dinamici
  final Function selectColor; // Funzione per determinare i colori
  final Map<String, ValueNotifier<double>> percentageNotifier;

  @override
  State<LiquidsOnBoardContainer> createState() {
    return _LiquidsOnBoardContainer();
  }
}

class _LiquidsOnBoardContainer extends State<LiquidsOnBoardContainer> {
  // Metodo per calcolare la percentuale di liquidi a bordo
  double litresOnBoardPercentageCalc(double litres, double maxCapacity) {
    return maxCapacity == 0 ? 0 : (litres / maxCapacity) * 100;
  }

  // Metodo per calcolare litri e capacità massima in modo dinamico
  Map<String, double> litresOnBoardCalc(List<Tank> tanks) {
    double totalLitres = 0;
    double totalCapacity = 0;

    for (var tank in tanks) {
      totalLitres += tank.liters;
      totalCapacity += tank.maxCapacity;
    }

    return {
      'litres': totalLitres,
      'maxCapacity': totalCapacity,
    };
  }

  // Metodo per generare i widget dei tank
  Widget tankManage(String prefix, List<Tank> tanks, double width) {
    Map<String, double> updatedValues = litresOnBoardCalc(tanks);
    // Calcola i valori dinamicamente
    double litresOnBoard = updatedValues['litres']!;
    double maxCapacity = updatedValues['maxCapacity']!;
    double litresPercentage =
        litresOnBoardPercentageCalc(litresOnBoard, maxCapacity);
    // Aggiorna il ValueNotifier con la nuova percentuale
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.percentageNotifier[prefix]!.value = litresPercentage;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prefix,
          style: TextStyle(
            color: widget.selectColor(prefix),
            fontWeight: FontWeight.bold,
            fontSize: width * 0.011,
          ),
        ),
        Text(
          '${litresOnBoard.toStringAsFixed(1)} lt',
          style: TextStyle(
            color: widget.selectColor(prefix),
            fontWeight: FontWeight.bold,
            fontSize: width * 0.01,
          ),
        ),
        Text(
          '${litresPercentage.toStringAsFixed(2)} %',
          style: TextStyle(
            color: widget.selectColor(prefix),
            fontWeight: FontWeight.bold,
            fontSize: width * 0.01,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(0, 0, 0, 0.4),
      ),
      width: width * 0.8,
      height: height * 0.15,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(""),
                Text(
                  "Liquids On Board",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.01,
                  ),
                ),
                Text(
                  "Percentage(%)",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.01,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: width * 0.015,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: widget.tanksData.entries.map((entry) {
                  return tankManage(entry.key, entry.value, width);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
