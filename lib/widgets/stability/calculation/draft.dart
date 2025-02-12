import 'package:flutter/material.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/services/wind_force.dart';
import 'package:plimsy/widgets/3d_model/model3d_viewer.dart';
import 'package:plimsy/widgets/spinner/custom_spinner.dart';
import 'package:plimsy/widgets/stability/calculation/graphics.dart';
import 'package:plimsy/widgets/stability/calculation/hydrostatic.dart';
import 'package:plimsy/widgets/stability/calculation/load.dart';
import 'package:plimsy/widgets/stability/calculation/stability_criteria.dart';
import 'package:plimsy/widgets/stability/calculation/vessel_status.dart';
import 'package:plimsy/widgets/stability/calculation/vessel_trim.dart';
import 'package:plimsy/widgets/stability/calculation/wind.dart';

class Draft extends StatefulWidget {
  Draft(
      {super.key,
      required this.isLoading,
      required this.draftData,
      required this.data,
      required this.getMaxLoad,
      required this.allTanks,
      required this.firstDraft,
      required this.windCalc,
      required this.intactData,
      required this.toReachMaxLoad,
      required this.updateToReachMaxLoad,
      required this.draftUpdated});

  bool draftUpdated;
  Function updateToReachMaxLoad;
  double toReachMaxLoad;
  Function windCalc;
  bool firstDraft;
  final bool isLoading; // Stato di caricamento passato dal genitore
  Map<String, dynamic> intactData;
  final Map<String, dynamic> draftData; // Dati passati dal genitore
  final Map<String, dynamic> data;
  Function getMaxLoad;
  Map<String, List<Tank>> allTanks;

  @override
  State<Draft> createState() {
    return _Draft();
  }
}

class _Draft extends State<Draft> with TickerProviderStateMixin {
  Size? screenSize;
  Offset windowPosition1 = const Offset(0, 0);
  Offset windowPosition2 = const Offset(0, 0);
  Offset windowPosition3 = const Offset(0, 0);
  Offset windowPosition4 = const Offset(0, 0);
  Offset windowPosition5 = const Offset(0, 0);
  Offset windowPosition6 = const Offset(0, 0);
  Offset windowPosition7 = const Offset(0, 0);

  WindForce windForce = WindForce();

  // Stato per gestire se una finestra è espansa o chiusa
  Map<String, bool> isExpandedMap = {
    "Wind force settings": true,
    "Load Capacity": true,
    "Hydrostatic Information": true,
    "Vessel Trim Information": true,
    "Graphics-Longitudinal Strength": true,
    "Vessel Status": true,
    "Stability criteria compliance": true,
  };

  Widget selectContent(String title) {
    final draftDataAvailable = widget.draftData.isNotEmpty;
    final intactDataAvailable = widget.intactData.isNotEmpty;
    switch (title) {
      case "Wind force settings":
        return Wind(
          firstDraft: widget.firstDraft,
          windCalc: widget.windCalc,
        );
      case "Load Capacity":
        return Load(
          data: widget.data,
          getMaxLoad: widget.getMaxLoad,
          allTanks: widget.allTanks,
          updateToReachMaxLoad: widget.updateToReachMaxLoad,
        );
      case "Hydrostatic Information":
        return Hydrostatic(
          hydroInfo: draftDataAvailable
              ? widget.draftData["draftCalcResults"]["hydroAndImmersions"]
              : null,
        );
      case "Vessel Trim Information":
        return VesselTrim(
          heelValue: draftDataAvailable
              ? widget.draftData["draftCalcResults"]["heel"]
              : "0.00°",
          trimValue: draftDataAvailable
              ? widget.draftData["draftCalcResults"]["trim"]
              : "0.00°",
          vesselImmersion: draftDataAvailable
              ? widget.draftData["draftCalcResults"]["hydroAndImmersions"]
                  ["immersions"]["vesselImmersion"]
              : null,
        );
      case "Graphics-Longitudinal Strength":
        return Graphics(
          frames: draftDataAvailable
              ? widget.draftData["longitudinalStrChart"]["frames"]
              : [0.0],
          momentDataSet: draftDataAvailable
              ? widget.draftData["longitudinalStrChart"]["momentDataSet"]
              : [0.0],
          shearDataSet: draftDataAvailable
              ? widget.draftData["longitudinalStrChart"]["shearDataSet"]
              : [0.0],
          maxBendingMoment: draftDataAvailable
              ? widget.draftData["longitudinalStrChart"]["maxMoment"]
              : "0.0",
          maxShearValue: draftDataAvailable
              ? widget.draftData["longitudinalStrChart"]["maxShear"]
              : "0.0",
          intactData: intactDataAvailable ? widget.intactData : {},
        );
      case "Vessel Status":
        return VesselStatus(
          draftUpdated: widget.draftUpdated,
          firstDraft: widget.firstDraft,
          toReachMaxLoad: widget.toReachMaxLoad,
          criteriaIntact:
              intactDataAvailable ? widget.intactData["criteriaTable"] : null,
          stabilityScore:
              intactDataAvailable ? widget.intactData["stabilityScore"] : null,
        );
      case "Stability criteria compliance":
        return StabilityCriteria(
          stabilityCriteriaObjs: widget.data["stabilityCriteriaObjs"],
          criteriaIntact:
              intactDataAvailable ? widget.intactData["criteriaTable"] : {},
        );
      default:
        return const Center(
          child: Text(
            "Demo Version...err",
            style: TextStyle(color: Colors.white),
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        screenSize = MediaQuery.of(context).size;
        if (screenSize != null) {
          windowPosition1 = const Offset(0, 0);
          windowPosition2 = Offset(0, screenSize!.height * 0.3);
          windowPosition3 = Offset(0, screenSize!.height * 0.6);
          windowPosition4 = Offset(screenSize!.width * 0.26, 0);
          windowPosition5 = Offset(screenSize!.width * 0.73, 0);
          windowPosition6 =
              Offset(screenSize!.width * 0.41, screenSize!.height * 0.6);
          windowPosition7 =
              Offset(screenSize!.width * 0.59, screenSize!.height * 0.6);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return widget.isLoading
        ? const CustomSpinner()
        : Expanded(
            child: Stack(
              children: [
                const Center(
                  child: Model3DViewer(),
                ),
                // Creiamo le finestre espandibili
                _buildDraggableAccordionWindow(
                  "Wind force settings",
                  windowPosition1,
                  (offset) => setState(() => windowPosition1 = offset),
                  screenSize!.width * 0.25,
                  screenSize!.height * 0.29,
                ),
                _buildDraggableAccordionWindow(
                  "Load Capacity",
                  windowPosition2,
                  (offset) => setState(() => windowPosition2 = offset),
                  screenSize!.width * 0.25,
                  screenSize!.height * 0.29,
                ),
                _buildDraggableAccordionWindow(
                  "Hydrostatic Information",
                  windowPosition3,
                  (offset) => setState(() => windowPosition3 = offset),
                  screenSize!.width * 0.4,
                  screenSize!.height * 0.27,
                ),
                _buildDraggableAccordionWindow(
                  "Vessel Trim Information",
                  windowPosition4,
                  (offset) => setState(() => windowPosition4 = offset),
                  screenSize!.width * 0.46,
                  screenSize!.height * 0.25,
                ),
                _buildDraggableAccordionWindow(
                  "Graphics-Longitudinal Strength",
                  windowPosition5,
                  (offset) => setState(() => windowPosition5 = offset),
                  screenSize!.width * 0.27,
                  screenSize!.height * 0.5,
                ),
                _buildDraggableAccordionWindow(
                  "Vessel Status",
                  windowPosition6,
                  (offset) => setState(() => windowPosition6 = offset),
                  screenSize!.width * 0.17,
                  screenSize!.height * 0.27,
                ),
                _buildDraggableAccordionWindow(
                  "Stability criteria compliance",
                  windowPosition7,
                  (offset) => setState(() => windowPosition7 = offset),
                  screenSize!.width * 0.41,
                  screenSize!.height * 0.27,
                ),
              ],
            ),
          );
  }

  Widget _buildDraggableAccordionWindow(
    String title,
    Offset position,
    ValueChanged<Offset> onDragEnd,
    double width,
    double height,
  ) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            onDragEnd(position + details.delta);
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width,
          height: isExpandedMap[title]!
              ? height
              : 56, // Altezza minima quando è chiuso
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black26)],
          ),
          child: Column(
            children: [
              // Header con titolo e icona per espandere/chiudere
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(1, 57, 75, 1),
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(8),
                    bottom: isExpandedMap[title]!
                        ? const Radius.circular(0)
                        : const Radius.circular(8),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isExpandedMap[title]!
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isExpandedMap[title] = !isExpandedMap[title]!;
                      });
                    },
                  ),
                ),
              ),
              // Contenuto visibile solo se espanso
              if (isExpandedMap[title]!)
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(1, 57, 75, 0.5),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(8)),
                    ),
                    width: double.infinity,
                    child: selectContent(title),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
