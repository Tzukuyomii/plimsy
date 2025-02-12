import 'package:flutter/material.dart';
import 'package:plimsy/models/tank.dart';

class DynamicRadioButtons extends StatefulWidget {
  DynamicRadioButtons(
      {super.key, required this.onTankSelected, required this.tanks});

  final Function(String) onTankSelected;
  Map<String, List<Tank>> tanks;

  @override
  State<DynamicRadioButtons> createState() => _DynamicRadioButtonsState();
}

class _DynamicRadioButtonsState extends State<DynamicRadioButtons> {
  String _selectedOption = ''; // Memorizza l'opzione selezionata

  @override
  void initState() {
    super.initState();
    _initializeSelectedTank();
  }

  void _initializeSelectedTank() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Controlla prima i tank di POOL con liters > 0
      for (var tank in widget.tanks["POOL"] ?? []) {
        if (tank.liters > 0) {
          _selectedOption = tank.id;
          widget.onTankSelected(tank.id);
          return;
        }
      }

      // Se nessun POOL è disponibile, controlla i tank di FRESH W. con liters > 0
      for (var tank in widget.tanks["FRESH W."] ?? []) {
        if (tank.liters > 0) {
          _selectedOption = tank.id;
          widget.onTankSelected(tank.id);
          return;
        }
      }

      // Se nessun tank ha liters > 0, non facciamo nulla e _selectedOption resta vuoto
    });
  }

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
            children: widget.tanks.entries
                .where(
                    (entry) => entry.key == "POOL" || entry.key == "FRESH W.")
                .expand((entry) => entry.value)
                .map((tank) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = tank.id;
                  });
                  widget.onTankSelected(tank.id);
                },
                child: Row(
                  children: [
                    // Cerchio del radio button
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedOption == tank.id
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
                          color: _selectedOption == tank.id
                              ? Colors.lightBlueAccent.shade100
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Testo del radio button
                    Text(
                      "${tank.prefix} ${tank.id}",
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
                children: widget.tanks.entries
                    .where((entry) =>
                        entry.key == "POOL" || entry.key == "FRESH W.")
                    .expand((entry) => entry.value)
                    .where((tank) =>
                        tank.id ==
                        _selectedOption) // Filtra solo il tank selezionato
                    .map((tank) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current: ${tank.liters.toStringAsFixed(2)} lt.',
                        style: TextStyle(
                            color: Colors.lightBlueAccent.shade100,
                            fontSize: width * 0.01),
                      ),
                      Text(
                        'Max cap: ${tank.maxCapacity.toStringAsFixed(2)} lt.',
                        style: TextStyle(
                            color: Colors.lightBlueAccent.shade100,
                            fontSize: width * 0.01),
                      ),
                    ],
                  );
                }).toList()),
          ),
      ],
    );
  }
}
