import 'package:flutter/material.dart';
import 'package:plimsy/data/liquids_data.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/widgets/stability/liquids/liquid_painter.dart';
import 'package:plimsy/widgets/stability/liquids/liquids_on_board_container.dart';
import 'package:plimsy/widgets/stability/liquids/slider_tank.dart';

class Tanks extends StatefulWidget {
  Tanks({
    super.key,
    required this.selectColor,
    required this.tanks,
    required this.updateTanks,
    required this.percentageNotifier,
  });

  Function selectColor;
  Function updateTanks;
  Map<String, List<Tank>> tanks;
  final Map<String, ValueNotifier<double>> percentageNotifier;

  @override
  State<Tanks> createState() {
    return _Tanks();
  }
}

class _Tanks extends State<Tanks> with SingleTickerProviderStateMixin {
  String selectedTank = "FUEL";
  late AnimationController _controller;
  String img = "assets/img/liquid-weights-pic/fuel.png";

  void updateTanks(String tankType, List<Tank> updatedTanks) {
    setState(() {
      widget.tanks[tankType] = updatedTanks;
    });
  }

  @override
  void initState() {
    super.initState();

    // Inizializza i ValueNotifier per ogni tipo di tank
    widget.tanks.keys.forEach((tankType) {
      widget.percentageNotifier[tankType] = ValueNotifier<double>(0.0);
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    widget.percentageNotifier.forEach((tankType, notifier) {
      // Controlla se il tankType è uno di quelli che non devono essere eliminati
      if (tankType != "FRESH W." && tankType != "POOL" && tankType != "POOLS") {
        notifier
            .dispose(); // Dispose solo se il tipo non è tra quelli da ignorare
      }
    });

    _controller.dispose();
    super.dispose();
  }

  void selectImage() {
    setState(() {
      if (selectedTank == "FUEL") {
        img = "assets/img/liquid-weights-pic/fuel.png";
      }
      if (selectedTank == "OIL") {
        img = "assets/img/liquid-weights-pic/oil.png";
      }
      if (selectedTank == "FRESH W.") {
        img = "assets/img/liquid-weights-pic/fresh_w.png";
      }
      if (selectedTank == "UREA") {
        img = "assets/img/liquid-weights-pic/urea.png";
      }
      if (selectedTank == "POOL") {
        img = "assets/img/liquid-weights-pic/pool.png";
      }
      if (selectedTank == "SEWAGE") {
        img = "assets/img/liquid-weights-pic/sewage.png";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(165, 45, 45, 0.4),
              Color.fromRGBO(100, 81, 81, 0.4),
            ],
            center: Alignment.topCenter,
            radius: 0.8,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            LiquidsOnBoardContainer(
              tanksData: widget.tanks,
              selectColor: widget.selectColor,
              percentageNotifier: widget.percentageNotifier,
            ),
            SizedBox(
              width: width,
              height: height * 0.3,
              child: Center(
                child: Image.asset(
                  img,
                  width: width * 0.9,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.tanks.entries
                  .where((entry) => entry.key != "POOLS")
                  .map((entry) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedTank = entry.key;
                      selectImage();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    width: width * 0.1,
                    height: height * 0.07,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: LiquidPainter(
                                  _controller.value,
                                  widget.selectColor(entry.key),
                                  widget.percentageNotifier[entry.key]!.value,
                                ),
                                child: const SizedBox.expand(),
                              );
                            },
                          ),
                          Text(
                            entry.key,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.011),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (selectedTank.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SliderTank(
                    isPools: false,
                    updateTanks: updateTanks,
                    tanksData: widget.tanks,
                    selectedTank: selectedTank,
                    selectColor: widget.selectColor,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
