import 'package:flutter/material.dart';

class CustomRadioButtons extends StatefulWidget {
  CustomRadioButtons({
    super.key,
    required this.onChanged,
  });

  final Function(String) onChanged;

  @override
  _CustomRadioButtonsState createState() => _CustomRadioButtonsState();
}

class _CustomRadioButtonsState extends State<CustomRadioButtons> {
  String _selectedOption = "Tech Support";

  final Map<String, String> optionValues = {
    "Tech Support": "ask",
    "Bug Report": "bug",
    "License/Commercial": "lic",
  };

  @override
  Widget build(BuildContext context) {
    final options = ["Tech Support", "Bug Report", "License/Commercial"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options.map((option) {
        final isSelected = _selectedOption == option;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = option;
              widget.onChanged(optionValues[_selectedOption]!);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
                width: isSelected ? 2 : 1,
              ),
              color: const Color.fromRGBO(59, 103, 141, 1),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isSelected
                    ? Colors.white
                    : const Color.fromARGB(104, 255, 255, 255),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
