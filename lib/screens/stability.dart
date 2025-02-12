import 'package:flutter/material.dart';
import 'package:plimsy/models/content.dart';
import 'package:plimsy/models/draftModel.dart';
import 'package:plimsy/models/intactModel.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/models/wind_calc_model.dart';
import 'package:plimsy/services/draft.dart';
import 'package:plimsy/services/intact.dart';
import 'package:plimsy/services/wind_force.dart';
import 'package:plimsy/widgets/spinner/spinner_overlay.dart';
import 'package:plimsy/widgets/spinner/spinner_provider.dart';
import 'package:plimsy/widgets/stability/calculation/draft.dart';
import 'package:plimsy/widgets/stability/fixed/fixed.dart';
import 'package:plimsy/widgets/stability/liquids/pools.dart';
import 'package:plimsy/widgets/stability/menu_stability.dart';
import 'package:plimsy/widgets/stability/liquids/tanks.dart';
import 'package:provider/provider.dart';

class Stability extends StatefulWidget {
  Stability(
      {super.key,
      required this.data,
      required this.apiKey,
      required this.forceHeeling,
      required this.seaWaterDensity});

  String forceHeeling;
  String seaWaterDensity;
  String apiKey;
  Map<String, dynamic> data;

  @override
  State<Stability> createState() {
    return _Stability();
  }
}

class _Stability extends State<Stability> {
  bool draftUpdated = false;
  double toReachMaxLoad = 0.0;
  Map<String, dynamic> _draftData = {};
  Map<String, dynamic> _intactData = {};
  bool _isDraftLoading = false; // Stato di caricamento
  bool firstDraft = false;
  final Map<String, ValueNotifier<double>> percentageNotifiers = {};
  String showContent = "Tanks";
  double? totalDisplacement;

  DraftService draftService = DraftService();
  WindForce windForce = WindForce();
  Intact intact = Intact();

  late Map<String, List<Tank>> allTanks;

  @override
  void initState() {
    super.initState();
    print("FORCE HEELING ${widget.forceHeeling}");

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

  void draft() async {
    final spinner = context.read<SpinnerProvider>();
    spinner.showSpinner();

    try {
      // Splitta `allTanks` in tanks e pools
      final splittedPools = allTanks["POOLS"] ?? []; // Recupera i pools
      final splittedTanks = {...allTanks}..remove("POOLS");
      double water = double.parse(widget.seaWaterDensity);

      DraftModel draftModel = DraftModel(
          tanks: splittedTanks,
          pools: splittedPools,
          fixedWeightTableData: widget.data["fixedWeigthTableData"]
              ["tableData"],
          totalDisplacement: totalDisplacement!,
          seaWaterDensity: water);

      Content content = Content(request: "draft", body: draftModel);
      final newData = await draftService.draft(widget.apiKey, content);

      setState(() {
        _draftData = newData; // Aggiorna i dati
        firstDraft = true;
        if (toReachMaxLoad < 0) {
          draftUpdated = false;
        } else {
          draftUpdated = true;
        }
      });
      spinner.hideSpinner();
    } catch (e) {
      print("Errore durante il fetch dei dati: $e");
      spinner.hideSpinner();
    }
  }

  void windCalc(double force, double degrees) async {
    final spinner = context.read<SpinnerProvider>();
    spinner.showSpinner();

    try {
      WindCalcModel windModel = WindCalcModel(force: force, degrees: degrees);

      Content content = Content(request: "wind-calc", body: windModel);
      final newData = await windForce.windForce(widget.apiKey, content);

      setState(() {
        _draftData = newData; // Aggiorna i dati
      });
      spinner.hideSpinner();
    } catch (e) {
      print("Errore durante il fetch dei dati: $e");
      spinner.hideSpinner();
    }
  }

  double getMaxLoad(double load) {
    return totalDisplacement = load;
  }

  void updateToReachMaxLoad(double value) {
    setState(() {
      toReachMaxLoad = value;
    });
  }

  void intactService() async {
    final spinner = context.read<SpinnerProvider>();
    spinner.showSpinner();

    try {
      Intactmodel intactmodel = Intactmodel(forcedHeeling: widget.forceHeeling);

      Content content = Content(request: "stability", body: intactmodel);
      final newData = await intact.stability(widget.apiKey, content);

      setState(() {
        _intactData = newData;
      });

      print("STABILITY RESPONSE $newData");

      spinner.hideSpinner();
    } catch (e) {
      print("Errore durante il fetch dei dati: $e");
      spinner.hideSpinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    draftUpdated: draftUpdated,
                    changeContent: changeContent,
                    showContent: showContent,
                    data: widget.data,
                    draft: draft,
                    firstDraft: firstDraft,
                    intactService: intactService,
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
                  if (showContent == "Fixed")
                    Fixed(
                      data: widget.data,
                    ),
                  if (showContent == "Calculate")
                    Draft(
                      draftUpdated: draftUpdated,
                      toReachMaxLoad: toReachMaxLoad,
                      updateToReachMaxLoad: updateToReachMaxLoad,
                      isLoading: _isDraftLoading,
                      draftData: _draftData,
                      data: widget.data,
                      getMaxLoad: getMaxLoad,
                      allTanks: allTanks,
                      firstDraft: firstDraft,
                      windCalc: windCalc,
                      intactData: _intactData,
                    ),
                ],
              ),
            ),
          ),
          const SpinnerOverlay()
        ],
      ),
    );
  }
}
