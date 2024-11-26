import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  Dropdown({super.key, required this.dropDownValue});
  String? dropDownValue;
  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
            color: Colors.blue, width: 2), // Colore e larghezza dei bordi
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButton<String>(
        value: widget.dropDownValue,
        isExpanded: true, // Rende il bottone più largo
        items: <String>['main-deck', 'lower-deck', 'observation-deck']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            widget.dropDownValue = newValue;
          });
        },
        dropdownColor: Colors.white, // Colore di sfondo del dropdown
        elevation: 4, // Ombra della tendina
        icon: Icon(Icons.arrow_drop_down), // Icona della tendina
      ),
    );
  }
}
