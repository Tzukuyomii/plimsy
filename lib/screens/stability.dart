import 'package:flutter/material.dart';
import 'package:plimsy/widgets/menus/menu_stability.dart';

class Stability extends StatelessWidget {
  const Stability({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          child: const MenuStability(),
        ),
      ),
    );
  }
}
