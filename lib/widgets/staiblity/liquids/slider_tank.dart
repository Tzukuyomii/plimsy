import 'package:flutter/material.dart';
import 'package:plimsy/data/tanks_data.dart';
import 'package:plimsy/models/tank.dart';

class SliderTank extends StatefulWidget {
  SliderTank(
      {super.key, required this.selectedTank, required this.selectColor});

  Function selectColor;
  String selectedTank;

  @override
  State<SliderTank> createState() {
    return _SliderTank();
  }
}

class _SliderTank extends State<SliderTank> {
  List _buildRowContent(String selected) {
    switch (selected) {
      case 'OIL':
        return mockTanks.oil;
      //  [
      //   const Icon(Icons.star, color: Colors.yellow),
      //   const SizedBox(width: 10),
      //   const Text('Contenuto per Elemento 1',
      //       style: TextStyle(fontSize: 18, color: Colors.yellow)),
      // ];
      case 'FRESH WATER':
        return mockTanks.freshW;
      //  [
      //   const Icon(Icons.favorite, color: Colors.red),
      //   const SizedBox(width: 10),
      //   const Text('Contenuto per Elemento 2',
      //       style: TextStyle(fontSize: 18, color: Colors.red)),
      // ];
      case 'UREA':
        return mockTanks.urea;
      //  [
      //   const Icon(Icons.check_circle, color: Colors.green),
      //   const SizedBox(width: 10),
      //   const Text('Contenuto per Elemento 3',
      //       style: TextStyle(fontSize: 18, color: Colors.green)),
      // ];
      case 'FUEL':
        return mockTanks.fuel;
      //  [
      //   const Icon(Icons.warning, color: Colors.orange),
      //   const SizedBox(width: 10),
      //   const Text('Contenuto per Elemento 4',
      //       style: TextStyle(fontSize: 18, color: Colors.orange)),
      // ];
      case 'POOL':
        return mockTanks.pool;
      //  [
      //   const Icon(Icons.warning, color: Colors.lightBlue),
      //   const SizedBox(width: 10),
      //   const Text('Contenuto per Elemento 5',
      //       style: TextStyle(fontSize: 18, color: Colors.lightBlue)),
      // ];
      case 'SEWAGE':
        return mockTanks.sewage;

      case 'POOLS':
        return mockPoolsTanks;

      default:
        return [const Text('Nessun elemento selezionato')];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.selectColor(widget.selectedTank),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildRowContent(widget.selectedTank)
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              Tank tank = entry.value;

              return Container(
                margin:
                    index != _buildRowContent(widget.selectedTank).length - 1
                        ? EdgeInsets.only(right: width * 0.01)
                        : EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Slider(
                    activeColor: widget.selectColor(widget.selectedTank),
                    inactiveColor: Colors.grey,
                    value: tank.liters,
                    min: 0,
                    max: tank.maxCapacity,
                    divisions: 100,
                    onChanged: (double value) {
                      setState(() {
                        tank.liters = value;
                      });
                    },
                    label: tank.liters.round().toString(),
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
