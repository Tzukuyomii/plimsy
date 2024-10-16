import 'package:flutter/material.dart';
import 'package:plimsy/models/tank.dart';

class Tanks extends StatelessWidget {
  Tanks({super.key});

  List<Tank> liquidsOnBoardS = [
    const Tank(
        id: "1",
        maxCapacity: 523 * 0.985,
        liters: 0,
        prefix: "DIRTY OIL",
        permeability: 0.985,
        weightSpec: 0.92),
    const Tank(
        id: "2",
        maxCapacity: 523 * 0.985,
        liters: 0,
        prefix: "FRESH WATER",
        permeability: 0.985,
        weightSpec: 0.92),
    const Tank(
        id: "3",
        maxCapacity: 523 * 0.985,
        liters: 0,
        prefix: "UREA",
        permeability: 0.985,
        weightSpec: 0.92),
    const Tank(
        id: "3",
        maxCapacity: 523 * 0.985,
        liters: 0,
        prefix: "UREA",
        permeability: 0.985,
        weightSpec: 0.92),
    const Tank(
        id: "3",
        maxCapacity: 523 * 0.985,
        liters: 0,
        prefix: "UREA",
        permeability: 0.985,
        weightSpec: 0.92),
  ];

  Color selectColor(String prefix) {
    if (prefix == "DIRTY OIL") {
      return Colors.yellow;
    } else if (prefix == "FRESH WATER") {
      return Colors.blueAccent;
    } else if (prefix == "UREA") {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  Widget tankManage(Tank tank) {
    return Column(
      children: [
        Text(
          tank.prefix,
          style: TextStyle(
            color: selectColor(tank.prefix),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${tank.maxCapacity.toString()} lt',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: liquidsOnBoardS.map((tank) {
                            return tankManage(tank);
                          }).toList(),
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
              children: liquidsOnBoardS.map((tank) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(190, 0, 0, 0),
                  ),
                  width: width * 0.1,
                  height: height * 0.08,
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        tank.prefix,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
