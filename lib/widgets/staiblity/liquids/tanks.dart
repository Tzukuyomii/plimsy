import 'package:flutter/material.dart';
import 'package:plimsy/data/liquids_data.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/widgets/staiblity/liquids/liquid_painter.dart';
import 'package:plimsy/widgets/staiblity/liquids/liquids_on_board_container.dart';
import 'package:plimsy/widgets/staiblity/liquids/slider_tank.dart';

class Tanks extends StatefulWidget {
  Tanks({super.key, required this.selectColor});

  Function selectColor;

  @override
  State<Tanks> createState() {
    return _Tanks();
  }
}

class _Tanks extends State<Tanks> with SingleTickerProviderStateMixin {
  String selectedTank = "FUEL";
  late AnimationController _controller;
  String img = "assets/img/liquid-weights-pic/fuel.png";

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

  void selectImage() {
    setState(() {
      if (selectedTank == "FUEL") {
        img = "assets/img/liquid-weights-pic/fuel.png";
      }
      if (selectedTank == "OIL") {
        img = "assets/img/liquid-weights-pic/oil.png";
      }
      if (selectedTank == "FRESH WATER") {
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
              selectColor: widget.selectColor,
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
              children: liquidsOnBoards.map((tank) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedTank = tank.prefix;
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
                                  widget.selectColor(tank.prefix),
                                ),
                                child: const SizedBox.expand(),
                              );
                            },
                          ),
                          Text(
                            tank.prefix,
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
                child: SliderTank(
                  selectedTank: selectedTank,
                  selectColor: widget.selectColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
