import 'package:flutter/material.dart';
import 'package:plimsy/data/hydrostatic_data.dart';

class Hydrostatic extends StatefulWidget {
  const Hydrostatic({super.key});
  @override
  State<Hydrostatic> createState() {
    return _Hydrostatic();
  }
}

class _Hydrostatic extends State<Hydrostatic> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(3), // Prima colonna più larga
          1: FlexColumnWidth(1), // Seconda colonna più stretta
          2: FlexColumnWidth(1), // Terza colonna più stretta
          3: FlexColumnWidth(1), // Quarta colonna più stretta
        },
        border:
            TableBorder.all(color: Colors.transparent), // Linee di separazione
        children: hydroItems.map((row) {
          return TableRow(
            children: [
              _buildCell(row["nome"], height * 0.03,
                  width), // Imposta altezza personalizzata
              _buildCell(row["acronimo"], height * 0.03, width),
              _buildCell(row["unita"], height * 0.03, width),
              _buildCell(row["valore"].toString(), height * 0.03, width),
            ],
          );
        }).toList(),
      ),
    );
  }
}

Widget _buildCell(String content, double height, double width) {
  return Padding(
    padding: EdgeInsets.all(height * 0.05),
    child: Container(
      color: const Color.fromRGBO(15, 42, 50, 1),
      height: height, // Altezza personalizzata
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(height * 0.05),
      child: Text(
        content,
        style: TextStyle(
          color: Colors.white,
          fontSize: width * 0.01,
        ),
      ),
    ),
  );
}
