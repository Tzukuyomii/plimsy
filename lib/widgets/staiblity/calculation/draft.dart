import 'package:flutter/material.dart';
import 'package:plimsy/widgets/3d_model/model3d_viewer.dart';
import 'package:plimsy/widgets/staiblity/calculation/graphics.dart';
import 'package:plimsy/widgets/staiblity/calculation/hydrostatic.dart';
import 'package:plimsy/widgets/staiblity/calculation/load.dart';
import 'package:plimsy/widgets/staiblity/calculation/stability_criteria.dart';
import 'package:plimsy/widgets/staiblity/calculation/vessel_status.dart';
import 'package:plimsy/widgets/staiblity/calculation/vessel_trim.dart';
import 'package:plimsy/widgets/staiblity/calculation/wind.dart';

class Draft extends StatefulWidget {
  const Draft({super.key});

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
    switch (title) {
      case "Wind force settings":
        return const Wind();
      case "Load Capacity":
        return const Load();
      case "Hydrostatic Information":
        return const Hydrostatic();
      case "Vessel Trim Information":
        return const VesselTrim();
      case "Graphics-Longitudinal Strength":
        return const Graphics();
      case "Vessel Status":
        return const VesselStatus();
      case "Stability criteria compliance":
        return const StabilityCriteria();
      default:
        return const Text("Titolo Errato");
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
    return Expanded(
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: selectContent(title),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
