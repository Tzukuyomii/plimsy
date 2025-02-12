import 'package:flutter/material.dart';
import 'package:plimsy/widgets/stability/fixed/table_fixed.dart';

class FixedAccordion extends StatefulWidget {
  FixedAccordion({
    super.key,
    required this.dropDownValue,
    required this.fixedWeigthTableData,
  });

  final List<dynamic> fixedWeigthTableData;
  String? dropDownValue;
  @override
  State<FixedAccordion> createState() => _FixedAccordion();
}

class _FixedAccordion extends State<FixedAccordion> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width * 0.5,
      // Altezza minima quando è chiuso
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header con titolo e icona per espandere/chiudere
          Container(
            decoration: BoxDecoration(
              color: isExpanded
                  ? const Color.fromRGBO(151, 151, 151, 1)
                  : const Color(0xFF008B8B),
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(8),
                bottom: isExpanded
                    ? const Radius.circular(0)
                    : const Radius.circular(8),
              ),
            ),
            child: ListTile(
              title: Text(
                isExpanded ? "Fixed Weights" : "Show table",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
          // Contenuto visibile solo se espanso
          if (isExpanded)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.637),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              width: double.infinity,
              child: TableFixed(
                initialData: widget.fixedWeigthTableData,
              ),
            ),
        ],
      ),
    );
  }
}
