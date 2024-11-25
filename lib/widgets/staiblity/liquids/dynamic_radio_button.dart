import 'package:flutter/material.dart';

class DynamicRadioButtons extends StatefulWidget {
  const DynamicRadioButtons({super.key});

  @override
  State<DynamicRadioButtons> createState() => _DynamicRadioButtonsState();
}

class _DynamicRadioButtonsState extends State<DynamicRadioButtons> {
  String _selectedOption = ''; // Memorizza l'opzione selezionata
  final List<String> options = [
    'F.W. 14',
    'F.W. 21',
    'F.W. 23',
    'P.T. 25'
  ]; // Lista dinamica

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Contenitore principale per i radio button
        Container(
          width: width * 0.3,
          height: height * 0.05,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4), // Colore di sfondo
            borderRadius: BorderRadius.circular(20), // Angoli arrotondati
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: options.map((option) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = option;
                  });
                },
                child: Row(
                  children: [
                    // Cerchio del radio button
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedOption == option
                            ? Colors.white
                            : Colors.transparent,
                        border: Border.all(
                          color: Colors.lightBlueAccent.shade100,
                          width: 2,
                        ),
                      ),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedOption == option
                              ? Colors.lightBlueAccent.shade100
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Testo del radio button
                    Text(
                      option,
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.01),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        // Box che mostra i dettagli dell'opzione selezionata
        if (_selectedOption.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent.shade100),
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current: 0.0 lt.',
                  style: TextStyle(
                      color: Colors.lightBlueAccent.shade100,
                      fontSize: width * 0.01),
                ),
                Text(
                  'Max cap: 0.0 lt.',
                  style: TextStyle(
                      color: Colors.lightBlueAccent.shade100,
                      fontSize: width * 0.01),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
