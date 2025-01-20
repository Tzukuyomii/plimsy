import 'package:flutter/material.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/widgets/staiblity/calculation/draft.dart';
import 'package:plimsy/widgets/staiblity/fixed/fixed.dart';
import 'package:plimsy/widgets/staiblity/liquids/pools.dart';
import 'package:plimsy/widgets/staiblity/menu_stability.dart';
import 'package:plimsy/widgets/staiblity/liquids/tanks.dart';

class Stability extends StatefulWidget {
  Stability({super.key, required this.data});

  Map<String, dynamic> data;

  @override
  State<Stability> createState() {
    return _Stability();
  }
}

class _Stability extends State<Stability> {
  final Map<String, ValueNotifier<double>> percentageNotifiers = {};
  String showContent = "Tanks";

  late Map<String, List<Tank>> allTanks;

  @override
  void initState() {
    super.initState();

    // Parsing dei tanks
    final rawTanks = widget.data["vesselTanks"]["tanks"];

    // Parsing delle pools
    final rawPools = widget.data["vesselPools"]["pools"] ?? [];

    // Combina tanks e pools
    allTanks = parseTanksWithPools(rawTanks, rawPools);
  }

  /// Funzione per combinare tanks e pools
  Map<String, List<Tank>> parseTanksWithPools(
      Map<String, dynamic> rawTanks, List<dynamic> rawPools) {
    final Map<String, List<Tank>> parsedTanks = {};

    // Parsing dei tanks
    rawTanks.forEach((key, value) {
      parsedTanks[key.toUpperCase()] = (value as List<dynamic>).map((tank) {
        return Tank(
          id: tank["id"].toString(),
          maxCapacity: _toDouble(tank["maxCapacity"]),
          liters: _toDouble(tank["liters"]),
          prefix: tank["prefix"] ?? "",
          permeability: _toDouble(tank["permeability"]),
          weightSpec: _toDouble(tank["weightSpec"]),
        );
      }).toList();
    });

    // Aggiunta delle pools sotto il gruppo "POOLS"
    if (rawPools.isNotEmpty) {
      parsedTanks["POOLS"] = rawPools.map((pool) {
        return Tank(
          id: pool["id"].toString(),
          maxCapacity: _toDouble(pool["maxCapacity"]),
          liters: _toDouble(pool["liters"]),
          prefix: pool["prefix"] ?? "",
          permeability: _toDouble(pool["permeability"]),
          weightSpec: _toDouble(pool["weightSpec"]),
        );
      }).toList();
    }

    return parsedTanks;
  }

  /// Funzione di utilità per convertire qualsiasi valore in double.
  double _toDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }
    if (value is int) {
      return value.toDouble();
    }
    if (value is double) {
      return value;
    }
    // Per gestire eventuali valori che non sono int o double (edge cases).
    throw ArgumentError("Valore non convertibile in double: $value");
  }

  void updateTanks(String tankType, List<Tank> updatedTanks) {
    setState(() {
      allTanks[tankType] = updatedTanks;
    });
  }

  Color selectColor(String prefix) {
    // Convertiamo il prefix in lowercase per abbinarlo ai dati del servizio
    String lowerCasePrefix = prefix.toLowerCase();

    // Cerchiamo il colore nella mappa restituita dal servizio
    String? hexColor = widget.data["tankTypeColors"][lowerCasePrefix];

    // Se il colore esiste, lo convertiamo da hex a Color
    if (hexColor != null) {
      return _hexToColor(hexColor);
    }

    // Altrimenti, restituiamo un colore di default
    return Colors.white;
  }

  /// Converte un colore in formato #RRGGBB in un oggetto Color
  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      return Color(int.parse('FF$hexColor', radix: 16));
    } else {
      throw ArgumentError("Formato colore non valido: $hexColor");
    }
  }

  void changeContent(String value) {
    setState(() {
      showContent = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(134, 1, 200, 235),
                Color.fromARGB(122, 9, 110, 150),
                Color.fromARGB(177, 1, 42, 117)
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              MenuStability(
                changeContent: changeContent,
                showContent: showContent,
                data: widget.data,
              ),
              if (showContent == "Tanks")
                Tanks(
                  percentageNotifier: percentageNotifiers,
                  updateTanks: updateTanks,
                  selectColor: selectColor,
                  tanks: allTanks,
                ),
              if (showContent == "Pools")
                Pools(
                  percentageNotifier: percentageNotifiers,
                  updateTanks: updateTanks,
                  selectColor: selectColor,
                  tanks: allTanks,
                ),
              if (showContent == "Fixed") const Fixed(),
              if (showContent == "Draft") const Draft(),
            ],
          ),
        ),
      ),
    );
  }
}
