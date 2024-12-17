import 'package:flutter/material.dart';
import 'package:plimsy/widgets/staiblity/liquids/liquid_painter.dart';

class Load extends StatefulWidget {
  const Load({super.key});
  @override
  State<Load> createState() {
    return _Load();
  }
}

class _Load extends State<Load> with TickerProviderStateMixin {
  late AnimationController _controller;

  final double maxLoad = 0;
  final double weigthLoaded = 0;

  @override
  void initState() {
    super.initState();

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
                "$maxLoad t",
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
                "$weigthLoaded%",
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
