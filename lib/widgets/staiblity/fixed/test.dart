import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plimsy/widgets/staiblity/fixed/fixed_accordion.dart';
import 'package:path_provider/path_provider.dart';

class Test extends StatefulWidget {
  Test({super.key, required this.data});

  Map<String, dynamic> data;

  @override
  State<Test> createState() {
    return _Fixed();
  }
}

class _Fixed extends State<Test> with TickerProviderStateMixin {
  List<Offset> _tapPositions = []; // Per tracciare il punto del click
  String _dropdownValue = "";
  List<String> _imagePaths = [];
  final TransformationController _transformationController =
      TransformationController(); // Controller per trasformazioni

  @override
  void initState() {
    super.initState();
    _loadImages(); // Carica le immagini all'avvio del widget
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  Future<void> _loadImages() async {
    try {
      // Ottieni il percorso della directory
      final directory = await getApplicationDocumentsDirectory();
      final imageDir = Directory('${directory.path}/services_folder');

      if (await imageDir.exists()) {
        // Filtra i file che contengono "-deck" nel nome e hanno estensione immagine
        final images = imageDir
            .listSync()
            .where((file) =>
                file is File &&
                file.path.endsWith(
                    '.webp') && // Filtra solo le immagini con estensione webp
                file.path
                    .contains('-deck')) // Filtra i nomi che contengono "-deck"
            .map((file) => file.path)
            .toList();

        // Ordina le immagini per mettere "main-deck" come prima (se esiste)
        images.sort((a, b) {
          if (a.contains('main-deck')) return -1;
          if (b.contains('main-deck')) return 1;
          return 0;
        });

        // Aggiorna lo stato con le immagini caricate
        setState(() {
          _imagePaths = images;
          _dropdownValue =
              _imagePaths.first; // Imposta "main-deck" come valore iniziale
        });
      }
    } catch (e) {
      print('Errore nel caricamento delle immagini: $e');
    }
  }

  void _addTapPosition(TapDownDetails details) {
    final matrix = _transformationController.value;
    final inverseMatrix = Matrix4.tryInvert(matrix);

    if (inverseMatrix != null) {
      final transformedOffset =
          MatrixUtils.transformPoint(inverseMatrix, details.localPosition);

      print("Punto trasformato: $transformedOffset");

      // Dividi la griglia in quattro settori
      final sector = _determineSector(transformedOffset);
      print("Settore determinato: $sector");

      // Controlla se il punto è all'interno del perimetro del settore corrispondente
      final isInside = _checkPointInSector(transformedOffset, sector);

      if (true) {
        setState(() {
          _tapPositions
              .add(transformedOffset); // Aggiungi il punto solo se valido
        });
      } else {
        print("Punto fuori dal perimetro!");
      }
    }
  }

// Determina il settore del clic
  String _determineSector(Offset point) {
    final double width =
        1280.0; // Sostituisci con il valore della larghezza reale
    final double height = 768.0; // Sostituisci con il valore dell'altezza reale

    if (point.dx < width / 2 && point.dy < height / 2) {
      return "topLeftValue";
    } else if (point.dx >= width / 2 && point.dy < height / 2) {
      return "topRightValue";
    } else if (point.dx >= width / 2 && point.dy >= height / 2) {
      return "bottomRightValue";
    } else {
      return "bottomLeftValue";
    }
  }

// Controlla se il punto è all'interno del perimetro del settore
  bool _checkPointInSector(Offset point, String sector) {
    final List<dynamic> sectorValues =
        widget.data["vesselMeasures"]["decks"][2]["valuesCheck"][sector];

    final normalizedPolygon = sectorValues.map((vertex) {
      return [
        vertex[0] *
            (1280.0 /
                widget.data["vesselMeasures"]["decks"][2]
                    ["width"]), // Normalizza X
        vertex[1] *
            (768.0 /
                widget.data["vesselMeasures"]["decks"][2]
                    ["height"]) // Normalizza Y
      ];
    }).toList();

    print("Poligono normalizzato: $normalizedPolygon");

    return _isPointInPolygon(point, normalizedPolygon);
  }

  // Algoritmo per verificare se il punto è dentro un poligono
  bool _isPointInPolygon(Offset point, List<dynamic> polygon) {
    bool isInside = false;
    print("Punto da verificare: $point");
    print("Poligono: $polygon");

    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      final xi = polygon[i][0], yi = polygon[i][1];
      final xj = polygon[j][0], yj = polygon[j][1];

      final intersect = ((yi > point.dy) != (yj > point.dy)) &&
          (point.dx < (xj - xi) * (point.dy - yi) / (yj - yi) + xi);
      if (intersect) {
        isInside = !isInside;
      }
    }
    print("Il punto è dentro il poligono? $isInside");
    return isInside;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print("WIDTH $width");
    print("HEIGHT $height");

    return Expanded(
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              _addTapPosition(details);
            },
            child: InteractiveViewer(
              maxScale: 5.0, // Abilita lo zoom
              minScale: 1.0,
              transformationController: _transformationController,
              // Usa altezza dello schermo
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: FileImage(
                      _dropdownValue != ""
                          ? File(_dropdownValue)
                          : File(
                              "/data/user/0/com.example.plimsy/app_flutter/services_folder/main-deck.webp"),
                    ),
                  ),
                ),
                child: CustomPaint(
                  painter:
                      TapPainter(_tapPositions), // Disegna il punto cliccato
                ),
              ),
            ),
          ),
          //Contenuto in primo piano
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: FixedAccordion(dropDownValue: _dropdownValue),
                ), // Accordion
                SizedBox(
                  width: width * 0.02,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: DropdownButton<String>(
                    value: _dropdownValue,
                    items: _imagePaths.map((String path) {
                      return DropdownMenuItem<String>(
                        value: path,
                        child: Text(
                          path
                              .split('/')
                              .last
                              .split('.')
                              .first, // Rimuove directory ed estensione
                        ), // Mostra solo il nome del file
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TapPainter extends CustomPainter {
  final List<Offset> positions;

  TapPainter(this.positions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (final position in positions) {
      canvas.drawCircle(
          position, 10, paint); // Disegna un cerchio per ogni punto
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
