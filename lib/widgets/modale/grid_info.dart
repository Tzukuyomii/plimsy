import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridInfo extends StatelessWidget {
  GridInfo({super.key});

  List<String> gridItems =
      List<String>.generate(44, (index) => 'Item ${index + 1}');
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(
        gridItems.length,
        (index) {
          return Card(
            margin: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                gridItems[index],
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
