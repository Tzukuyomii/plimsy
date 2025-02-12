import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VesselTrim extends StatefulWidget {
  VesselTrim({super.key, this.vesselImmersion, this.trimValue, this.heelValue});

  Map<String, dynamic>? vesselImmersion;
  final String? trimValue;
  final String? heelValue;

  @override
  State<VesselTrim> createState() {
    return _VesselTrim();
  }
}

class _VesselTrim extends State<VesselTrim> {
  String trimImagePath = "";

  // Funzione per ottenere il percorso corretto del file
  Future<void> _getIconPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/services_folder/trim-icon.webp";

    // Controlla se il file esiste, altrimenti carica il modello 3D
    setState(() {
      trimImagePath = path; // Aggiorna il percorso per caricare il modello
    });
  }

  @override
  void initState() {
    _getIconPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double trimValue = double.parse(widget.trimValue!.replaceAll("°", ""));
    double heelValue = double.parse(widget.heelValue!.replaceAll("°", ""));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                trimImagePath.isEmpty
                    ? CircularProgressIndicator()
                    : Image.file(
                        File(trimImagePath),
                        width: width * 0.2,
                      ),
                Container(
                  width: double.infinity,
                  height: height * 0.03, // Altezza del container con gradiente
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment
                          .topCenter, // Partenza del gradiente in basso
                      end: Alignment.bottomCenter, // Fine del gradiente in alto
                      colors: [
                        Color.fromARGB(
                            255, 136, 137, 138), // Colore intenso in basso
                        Color.fromARGB(
                            0, 110, 110, 110), // Colore trasparente in alto
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Trim',
                      style: TextStyle(
                        fontSize: width * 0.0099,
                        color: Colors.white, // Colore del testo
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_drop_down,
                        color: trimValue < 0
                            ? const Color.fromARGB(255, 248, 18, 1)
                            : Colors.grey,
                        size: width * 0.03,
                      ),
                      Text(
                        "${widget.trimValue}",
                        style: TextStyle(
                          fontSize: width * 0.0099,
                          color: Colors.white, // Colore del testo
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: trimValue > 0
                            ? const Color.fromARGB(255, 248, 18, 1)
                            : Colors.grey,
                        size: width * 0.03,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: height *
                              0.065, // Altezza del container con gradiente
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment
                                  .topCenter, // Partenza del gradiente in basso
                              end: Alignment
                                  .bottomCenter, // Fine del gradiente in alto
                              colors: [
                                Color.fromARGB(255, 136, 137,
                                    138), // Colore intenso in basso
                                Color.fromARGB(0, 114, 114,
                                    114), // Colore trasparente in alto
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/img/calculations-main/heel-icon.png",
                            width: width * 0.05,
                          ),
                          Text(
                            "Heel",
                            style: TextStyle(
                              fontSize: width * 0.0099,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.rotate(
                      angle: 0.5 * 3.14159,
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: heelValue < 0
                            ? const Color.fromARGB(255, 248, 18, 1)
                            : Colors.grey,
                        size: width * 0.03,
                      ),
                    ),
                    Text(
                      "${widget.heelValue}",
                      style: TextStyle(
                        fontSize: width * 0.0099,
                        color: Colors.white, // Colore del testo
                      ),
                    ),
                    Transform.rotate(
                      angle: 1.5 * 3.14159, // Rotate 270 degrees (pi/2 * 3)
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: heelValue > 0
                            ? const Color.fromARGB(255, 248, 18, 1)
                            : Colors.grey,
                        size: width * 0.03,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "AFT MARK PT",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                        Text(
                          widget.vesselImmersion?["mAftSx"] ?? "-",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "FWD MARK PT",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                        Text(
                          widget.vesselImmersion?["mFwdSx"] ?? "-",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.vesselImmersion?["mAftC"] ?? "-",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                        Text(
                          widget.vesselImmersion?["mCenterC"] ?? "-",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                        Text(
                          widget.vesselImmersion?["mFwdC"] ?? "-",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/img/calculations-main/top-wpa-icon.png",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "AFT MARK SB",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                        Text(
                          widget.vesselImmersion?["mAftDx"] ?? "-",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "FWD MARK SB",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                        Text(
                          widget.vesselImmersion?["mFwdDx"] ?? "-",
                          style: TextStyle(
                            fontSize: width * 0.0075,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
