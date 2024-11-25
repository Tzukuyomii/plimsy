import 'package:flutter/material.dart';
import 'package:plimsy/data/liquids_data.dart';
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
  Widget tankManage(Tank tank, double width) {
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
          // '${tank.maxCapacity.toString()} lt',
          '0 lt',
          style: TextStyle(
            color: widget.selectColor(tank.prefix),
            fontWeight: FontWeight.bold,
            fontSize: width * 0.01,
          ),
        ),
        Text(
          '${tank.liters.toString()} %',
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
