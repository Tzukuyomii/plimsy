import 'package:flutter/material.dart';
import 'package:plimsy/data/liquids_data.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/widgets/staiblity/liquids/liquid_painter.dart';
import 'package:plimsy/widgets/staiblity/liquids/slider_tank.dart';

class Tanks extends StatefulWidget {
  const Tanks({super.key});

  @override
  State<Tanks> createState() {
    return _Tanks();
  }
}

class _Tanks extends State<Tanks> with SingleTickerProviderStateMixin {
  String selectedTank = "";
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    selectedTank = liquidsOnBoards[0].prefix;

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

  Color selectColor(String prefix) {
    if (prefix == "DIRTY OIL") {
      return Colors.yellow;
    } else if (prefix == "FRESH WATER") {
      return Colors.blueAccent;
    } else if (prefix == "UREA") {
      return Colors.green;
    } else if (prefix == "FUEL") {
      return Colors.pinkAccent;
    } else if (prefix == "POOL") {
      return Colors.lightBlue;
    } else {
      return Colors.white;
    }
  }

  Widget tankManage(Tank tank) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tank.prefix,
          style: TextStyle(
            color: selectColor(tank.prefix),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          // '${tank.maxCapacity.toString()} lt',
          '0 lt',
          style: TextStyle(
              color: selectColor(tank.prefix), fontWeight: FontWeight.bold),
        ),
        Text(
          '${tank.liters.toString()} %',
          style: TextStyle(
              color: selectColor(tank.prefix), fontWeight: FontWeight.bold),
        ),
      ],
    );
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(0, 0, 0, 0.4),
              ),
              width: width * 0.8,
              height: height * 0.15,
              child: Row(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(""),
                      Text(
                        "Liquids On Board",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Percentage(%)",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                              return tankManage(tank);
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width,
              height: height * 0.3,
              child: const Center(
                child: Text("data"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: liquidsOnBoards.map((tank) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedTank = tank.prefix;
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
                                  selectColor(tank.prefix),
                                ),
                                child: const SizedBox.expand(),
                              );
                            },
                          ),
                          Text(
                            tank.prefix,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
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
                child: SliderTank(
                  selectedTank: selectedTank,
                  selectColor: selectColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
