import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  RadioButton(
      {super.key,
      required this.onRadioButtonChange,
      required this.selecteOption});

  Function onRadioButtonChange;
  String selecteOption;

  @override
  State<RadioButton> createState() {
    return _RadioButton();
  }
}

class _RadioButton extends State<RadioButton> {
  String selectedOption = "2";

  BorderRadiusGeometry? borderRadiobutton(String value) {
    BorderRadiusGeometry? borderRadius;
    if (value == "first") {
      borderRadius = const BorderRadius.horizontal(
        left: Radius.circular(30),
      );
    } else if (value == "third") {
      borderRadius = const BorderRadius.horizontal(
        right: Radius.circular(30),
      );
    } else {
      borderRadius = null;
    }

    return borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // Riduce la larghezza della riga al contenuto
        children: [
          _buildCustomRadioButton("1", "Port", "first"), // Primo radio button
          _buildCustomRadioButton("2", "Auto", ""), // Secondo radio button
          _buildCustomRadioButton(
              "3", "Starboard", "third"), // Terzo radio button
        ],
      ),
    );
  }

  Widget _buildCustomRadioButton(
      String value, String title, String indexRadio) {
    bool isSelected =
        widget.selecteOption == value; // Controlla se è selezionato
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onRadioButtonChange(value);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.black, // Colore di sfondo quando selezionato
          border: Border.all(
            color: isSelected ? Colors.white : Colors.black, // Colore del bordo
            width: 2, // Larghezza del bordo
          ),
          borderRadius: borderRadiobutton(indexRadio),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 8), // Padding interno
        child: Row(
          mainAxisSize: MainAxisSize.min, // Riduce la larghezza al contenuto
          children: [
            Text(
              title, // Testo associato al RadioButton
              style: const TextStyle(
                color: Colors.white, // Colore del testo
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
