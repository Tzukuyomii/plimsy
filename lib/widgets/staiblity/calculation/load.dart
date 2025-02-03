import 'package:flutter/material.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/widgets/staiblity/liquids/liquid_painter.dart';

class Load extends StatefulWidget {
  Load(
      {super.key,
      required this.data,
      required this.getMaxLoad,
      required this.allTanks});

  Map<String, dynamic> data;
  Function getMaxLoad;
  Map<String, List<Tank>> allTanks;
  @override
  State<Load> createState() {
    return _Load();
  }
}

class _Load extends State<Load> with TickerProviderStateMixin {
  late AnimationController _controller;

  String vesselLoad = "0";
  String toReachMaxLoad = "0";

  @override
  void initState() {
    super.initState();

    calcolaPesoTotaleVessel(
      lightshipInfo: widget.data["lightshipInfo"],
      vesselTanks: widget.allTanks,
      maxVesselLoading: widget.data["maxVesselLoading"],
      fixedWeigthTableData: widget.data["fixedWeigthTableData"]["tableData"],
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void calcolaPesoTotaleVessel({
    required Map<String, dynamic> lightshipInfo,
    required Map<String, dynamic> vesselTanks,
    required List<dynamic> fixedWeigthTableData,
    required double maxVesselLoading,
  }) {
    // 1. Peso del lightship
    double lightshipWeight = lightshipInfo['weight'] ?? 0;

    // 2. Peso dei liquidi nei tank
    double pesoTotaleLiquidi = 0;
    vesselTanks.forEach((_, tanks) {
      for (var tank in tanks) {
        double liters = (tank.liters ?? 0).toDouble();
        double weightSpec = (tank.weightSpec ?? 0).toDouble();
        pesoTotaleLiquidi += (liters / 1000) * weightSpec;
      }
    });

    // 3. Peso fisso aggiuntivo
    double pesoTotaleFix = 0;
    for (var item in fixedWeigthTableData) {
      double weight = double.tryParse(item['weight'] ?? '0') ?? 0;
      pesoTotaleFix += weight;
    }
    double weigthLoaded = lightshipWeight + pesoTotaleLiquidi + pesoTotaleFix;
    double fixedAndLiquids = pesoTotaleFix + pesoTotaleLiquidi;

    widget.getMaxLoad(weigthLoaded);

    // 4. Calcolo peso totale
    setState(() {
      toReachMaxLoad = (maxVesselLoading - weigthLoaded).toStringAsFixed(3);

      double capacitaNetta = (maxVesselLoading - lightshipWeight);
      vesselLoad = ((fixedAndLiquids / capacitaNetta) * 100).toStringAsFixed(2);
    });

    // 5. Calcolo percentuale di riempimento

    // Risultati
    print(
        "Peso totale dell'imbarcazione: ${weigthLoaded.toStringAsFixed(2)} t");
    print("Percentuale di riempimento: $vesselLoad%");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ClipRRect(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/img/calculations-main/loadline-status.png",
              width: width * 0.08,
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: LiquidPainter(_controller.value, Colors.blue, 50),
                child: const SizedBox.expand(),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "TO REACH MAX LOADING:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.0077,
                ),
              ),
              Text(
                "$toReachMaxLoad t",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.01),
              ),
              Text(
                "THE VESSEL IS LOADED AT:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.0077,
                ),
              ),
              Text(
                "$vesselLoad%",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.01),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
