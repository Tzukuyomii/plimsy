import 'package:flutter/material.dart';
import 'package:plimsy/data/stability_criteria_data.dart';

class StabilityCriteria extends StatefulWidget {
  const StabilityCriteria({super.key});
  @override
  State<StabilityCriteria> createState() {
    return _StabilityCriteria();
  }
}

class _StabilityCriteria extends State<StabilityCriteria> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1), // Prima colonna più larga
          1: FlexColumnWidth(4), // Seconda colonna più stretta
          2: FlexColumnWidth(1), // Terza colonna più stretta
          3: FlexColumnWidth(1), // Quarta colonna più stretta
          4: FlexColumnWidth(1), // Quarta colonna più stretta
          5: FlexColumnWidth(1), // Quarta colonna più stretta
          6: FlexColumnWidth(1), // Quarta colonna più stretta
        },
        border:
            TableBorder.all(color: Colors.transparent), // Linee di separazione
        children: stabilityCriteriaItems.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;

          return TableRow(
            children: [
              _buildCell(row["code"], height * 0.03, width,
                  isHeader: index == 0),
              _buildCell(row["criterion"], height * 0.03, width,
                  isHeader: index == 0),
              _buildCell(row["limit"], height * 0.03, width,
                  isHeader: index == 0),
              _buildCell(row["unit"], height * 0.03, width,
                  isHeader: index == 0),
              _buildCell(row["value"], height * 0.03, width,
                  isHeader: index == 0),
              _buildCell(row["result"], height * 0.03, width,
                  isHeader: index == 0),
              _buildCell(row["margin"], height * 0.03, width,
                  isHeader: index == 0),
            ],
          );
        }).toList(),
      ),
    );
  }
}

Widget _buildCell(
  String content,
  double height,
  double width, {
  bool isHeader = false,
}) {
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
          fontSize: isHeader ? width * 0.011 : width * 0.01,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ),
  );
}
