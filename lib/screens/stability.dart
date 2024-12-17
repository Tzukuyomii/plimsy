import 'package:flutter/material.dart';
import 'package:plimsy/data/tanks_data.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/widgets/staiblity/calculation/draft.dart';
import 'package:plimsy/widgets/staiblity/fixed/fixed.dart';
import 'package:plimsy/widgets/staiblity/liquids/pools.dart';
import 'package:plimsy/widgets/staiblity/menu_stability.dart';
import 'package:plimsy/widgets/staiblity/liquids/tanks.dart';

class Stability extends StatefulWidget {
  const Stability({super.key});

  @override
  State<Stability> createState() {
    return _Stability();
  }
}

class _Stability extends State<Stability> {
  final Map<String, ValueNotifier<double>> percentageNotifiers = {};
  String showContent = "";

  final Map<String, List<Tank>> allTanks = {
    "FUEL": mockTanks.fuel,
    "OIL": mockTanks.oil,
    "FRESH WATER": mockTanks.freshW,
    "UREA": mockTanks.urea,
    "POOL": mockTanks.pool,
    "SEWAGE": mockTanks.sewage,
  };

  void updateTanks(String tankType, List<Tank> updatedTanks) {
    setState(() {
      if (tankType == "POOLS") {
        mockPools.pools = updatedTanks;
      } else {
        allTanks[tankType] = updatedTanks;
      }
    });
  }

  Color selectColor(String prefix) {
    if (prefix == "OIL") {
      return Colors.yellow;
    } else if (prefix == "FRESH WATER") {
      return Colors.blue.shade100;
    } else if (prefix == "UREA") {
      return Colors.green.shade200;
    } else if (prefix == "FUEL") {
      return Colors.red.shade100;
    } else if (prefix == "POOL" || prefix == "POOLS") {
      return Colors.lightBlueAccent.shade100;
    } else if (prefix == "SEWAGE") {
      return Colors.teal.shade100;
    } else {
      return Colors.white;
    }
  }

  void changeContent(String value) {
    setState(() {
      showContent = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(134, 1, 200, 235),
                Color.fromARGB(122, 9, 110, 150),
                Color.fromARGB(177, 1, 42, 117)
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              MenuStability(
                changeContent: changeContent,
                showContent: showContent,
              ),
              if (showContent == "Tanks")
                Tanks(
                  percentageNotifier: percentageNotifiers,
                  updateTanks: updateTanks,
                  selectColor: selectColor,
                  tanks: allTanks,
                ),
              if (showContent == "Pools")
                Pools(
                  percentageNotifier: percentageNotifiers,
                  updateTanks: updateTanks,
                  selectColor: selectColor,
                  tanks: allTanks,
                ),
              if (showContent == "Fixed") const Fixed(),
              if (showContent == "Draft") const Draft(),
            ],
          ),
        ),
      ),
    );
  }
}
