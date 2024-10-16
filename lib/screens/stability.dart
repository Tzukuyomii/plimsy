import 'package:flutter/material.dart';
import 'package:plimsy/widgets/menus/menu_stability.dart';
import 'package:plimsy/widgets/tanks.dart';

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
    return Scaffold(
      body: Container(
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
          children: [
            MenuStability(
              changeContent: changeContent,
            ),
            if (showContent == "Tanks") Tanks()
          ],
        ),
      ),
    );
  }
}
