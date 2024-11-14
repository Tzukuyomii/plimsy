import 'package:flutter/material.dart';
import 'package:plimsy/widgets/staiblity/calculation/draft.dart';
import 'package:plimsy/widgets/staiblity/fixed/fixed.dart';
import 'package:plimsy/widgets/staiblity/liquids/pools.dart';
import 'package:plimsy/widgets/staiblity/menu_stability.dart';
import 'package:plimsy/widgets/staiblity/liquids/tanks.dart';

class Stability extends StatefulWidget {
  const Stability({super.key});

  @override
  State<Stability> createState() {
    return _Stability();
  }
}

class _Stability extends State<Stability> {
  String showContent = "";

  void changeContent(String value) {
    setState(() {
      showContent = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(134, 1, 200, 235),
              Color.fromARGB(122, 9, 110, 150),
              Color.fromARGB(177, 1, 42, 117)
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MenuStability(
              changeContent: changeContent,
              showContent: showContent,
            ),
            if (showContent == "Tanks") const Tanks(),
            if (showContent == "Pools") const Pools(),
            if (showContent == "Fixed") const Fixed(),
            if (showContent == "Draft") const Draft(),
          ],
        ),
      ),
    );
  }
}
