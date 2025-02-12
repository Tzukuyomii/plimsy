import 'package:flutter/material.dart';
import 'package:plimsy/widgets/stability/calculation/graphic.dart';

class LongStr extends StatefulWidget {
  LongStr(
      {super.key,
      required this.frames,
      required this.momentDataSet,
      required this.shearDataSet,
      required this.maxBendingMoment,
      required this.maxShearValue});

  final List<dynamic> frames;
  final List<dynamic> shearDataSet;
  final List<dynamic> momentDataSet;
  String maxBendingMoment;
  String maxShearValue;
  @override
  State<StatefulWidget> createState() {
    return _LongStr();
  }
}

class _LongStr extends State<LongStr> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          child: Graphic(
            frames: widget.frames,
            shearDataSet: widget.shearDataSet,
            momentDataSet: widget.momentDataSet,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  color: Colors.blueAccent,
                  width: width * 0.02,
                  height: height * 0.015,
                ),
                SizedBox(
                  width: width * 0.003,
                ),
                Text(
                  "SHEAR(t)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.0099,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  color: Colors.red,
                  width: width * 0.02,
                  height: height * 0.015,
                ),
                SizedBox(
                  width: width * 0.003,
                ),
                Text(
                  "BENDING MOMENT(t.m / 10)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.0099,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.02,
              height: height * 0.015,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.005,
                    height: height * 0.015,
                    color: Colors.green,
                  ),
                  Container(
                    width: width * 0.005,
                    height: height * 0.015,
                    color: Colors.green,
                  ),
                  Container(
                    width: width * 0.005,
                    height: height * 0.015,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.003,
            ),
            Text(
              "B.M.MAX ALLOWABLE HOG.(t.m)",
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.0099,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.015,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "MAXIMUM BENDING MOMENT VALUE: ${widget.maxBendingMoment} tm",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.0099,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "MAXIMUM SHEAR VALUE: ${widget.maxShearValue} t",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.0099,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
