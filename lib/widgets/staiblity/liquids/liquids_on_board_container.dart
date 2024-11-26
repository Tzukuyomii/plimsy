import 'package:flutter/material.dart';
import 'package:plimsy/data/liquids_data.dart';
import 'package:plimsy/data/tanks_data.dart';
import 'package:plimsy/models/tank.dart';

class LiquidsOnBoardContainer extends StatefulWidget {
  LiquidsOnBoardContainer({super.key, required this.selectColor});

  Function selectColor;

  @override
  State<LiquidsOnBoardContainer> createState() {
    return _LiquidsOnBoardContainer();
  }
}

class _LiquidsOnBoardContainer extends State<LiquidsOnBoardContainer> {
  double litresOnBoardPercentageCalc(double litres, double maxCapacity) {
    return (litres / maxCapacity) * 100;
  }

  Map<String, double> litresOnBoardCalc(
    String prefix,
    double litres,
    double maxCapacity,
  ) {
    if (prefix == "FUEL") {
      for (int i = 0; i < mockFuelTanks.length; i++) {
        litres += mockFuelTanks[i].liters;
        maxCapacity += mockFuelTanks[i].maxCapacity;
      }
    } else if (prefix == "OIL") {
      for (int i = 0; i < mockOilTanks.length; i++) {
        litres += mockOilTanks[i].liters;
        maxCapacity += mockOilTanks[i].maxCapacity;
      }
    } else if (prefix == "FRESH WATER") {
      for (int i = 0; i < mockFreshWaterTanks.length; i++) {
        litres += mockFreshWaterTanks[i].liters;
        maxCapacity += mockFreshWaterTanks[i].maxCapacity;
      }
    } else if (prefix == "UREA") {
      for (int i = 0; i < mockUreaTanks.length; i++) {
        litres += mockUreaTanks[i].liters;
        maxCapacity += mockUreaTanks[i].maxCapacity;
      }
    } else if (prefix == "POOL") {
      for (int i = 0; i < mockPoolTanks.length; i++) {
        litres += mockPoolTanks[i].liters;
        maxCapacity += mockPoolTanks[i].maxCapacity;
      }
    } else if (prefix == "SEWAGE") {
      for (int i = 0; i < mockSewageTanks.length; i++) {
        litres += mockSewageTanks[i].liters;
        maxCapacity += mockSewageTanks[i].maxCapacity;
      }
    }

    // Restituisci un oggetto mappa con entrambi i valori
    return {'litres': litres, 'maxCapacity': maxCapacity};
  }

  Widget tankManage(Tank tank, double width) {
    double litresOnBoard = 0;
    double maxCapacity = 0;
    double litresPercentage = 0;

    Map<String, double> updatedValues =
        litresOnBoardCalc(tank.prefix, litresOnBoard, maxCapacity);
    litresOnBoard = updatedValues['litres']!;
    maxCapacity = updatedValues['maxCapacity']!;

    litresPercentage = litresOnBoardPercentageCalc(litresOnBoard, maxCapacity);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tank.prefix,
          style: TextStyle(
            color: widget.selectColor(tank.prefix),
            fontWeight: FontWeight.bold,
            fontSize: width * 0.011,
          ),
        ),
        Text(
          '${litresOnBoard.toStringAsFixed(1)} lt',
          style: TextStyle(
            color: widget.selectColor(tank.prefix),
            fontWeight: FontWeight.bold,
            fontSize: width * 0.01,
          ),
        ),
        Text(
          '${litresPercentage.toStringAsFixed(2)} %',
          style: TextStyle(
            color: widget.selectColor(tank.prefix),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: liquidsOnBoards.map((tank) {
                      return tankManage(tank, width);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
