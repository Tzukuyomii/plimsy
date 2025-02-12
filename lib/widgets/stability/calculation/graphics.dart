import 'package:flutter/material.dart';
import 'package:plimsy/widgets/stability/calculation/graphic.dart';
import 'package:plimsy/widgets/stability/calculation/long_str.dart';
import 'package:plimsy/widgets/stability/calculation/right_arm.dart';

class Graphics extends StatefulWidget {
  Graphics(
      {super.key,
      required this.frames,
      required this.momentDataSet,
      required this.shearDataSet,
      required this.maxBendingMoment,
      required this.maxShearValue,
      required this.intactData});

  Map<String, dynamic> intactData;
  final List<dynamic> frames;
  final List<dynamic> shearDataSet;
  final List<dynamic> momentDataSet;
  String maxBendingMoment;
  String maxShearValue;

  @override
  State<Graphics> createState() {
    return _Graphics();
  }
}

class _Graphics extends State<Graphics> {
  String showGraphic = "long";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showGraphic = "long";
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width * 0.13, height * 0.025),
                backgroundColor: const Color(0xFF008B8B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Long. Strength",
                style: TextStyle(color: Colors.white, fontSize: width * 0.009),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showGraphic = "right";
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width * 0.13, height * 0.025),
                backgroundColor: const Color(0xFF008B8B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Righting Arm",
                style: TextStyle(color: Colors.white, fontSize: width * 0.009),
              ),
            ),
          ],
        ),
        if (showGraphic == "long")
          LongStr(
              frames: widget.frames,
              momentDataSet: widget.momentDataSet,
              shearDataSet: widget.shearDataSet,
              maxBendingMoment: widget.maxBendingMoment,
              maxShearValue: widget.maxShearValue),
        if (showGraphic == "right")
          RightArm(
            intactData: widget.intactData,
          )
      ],
    );
  }
}
