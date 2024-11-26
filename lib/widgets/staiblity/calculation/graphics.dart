import 'package:flutter/material.dart';
import 'package:plimsy/widgets/staiblity/calculation/graphic.dart';

class Graphics extends StatefulWidget {
  const Graphics({super.key});
  @override
  State<Graphics> createState() {
    return _Graphics();
  }
}

class _Graphics extends State<Graphics> {
  final double _bendingMoment = 0;
  final double _shearValue = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
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
              onPressed: () {},
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
        const Graphic(),
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
                  "BENDING MOMENT(t.m)",
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
            "MAXIMUM BENDING MOMENT VALUE: $_bendingMoment tm",
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
            "MAXIMUM SHEAR VALUE: $_shearValue t",
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
