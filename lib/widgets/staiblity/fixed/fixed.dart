import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plimsy/widgets/staiblity/fixed/fixed_accordion.dart';
import 'package:path_provider/path_provider.dart';

class Fixed extends StatefulWidget {
  const Fixed({super.key});

  @override
  State<Fixed> createState() {
    return _Fixed();
  }
}

class _Fixed extends State<Fixed> with TickerProviderStateMixin {
  Offset? _tapPosition; // Per tracciare il punto del click
  String _dropdownValue = "";
  List<String> _imagePaths = [];
  final TransformationController _transformationController =
      TransformationController(); // Controller per trasformazioni

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Stack(
        children: [
          // Sfondo immagine manipolabile
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              setState(() {
                // Trasforma le coordinate del tocco in base alla trasformazione applicata
                final matrix = _transformationController.value;
                final inverseMatrix =
                    Matrix4.tryInvert(matrix); // Inverti la matrice
                if (inverseMatrix != null) {
                  // Trasforma le coordinate del clic
                  final transformedOffset = MatrixUtils.transformPoint(
                      inverseMatrix, details.localPosition);
                  _tapPosition = transformedOffset; // Salva la posizione reale
                }
              });
            },
            child: InteractiveViewer(
              maxScale: 5.0, // Abilita lo zoom
              minScale: 1.0,
              transformationController: _transformationController,
              child: SizedBox(
                width: width, // Usa larghezza dello schermo
                height: height, // Usa altezza dello schermo
                child: Container(
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
                  child: _tapPosition != null
                      ? CustomPaint(
                          painter: TapPainter(
                              _tapPosition!), // Disegna il punto cliccato
                        )
                      : null,
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
  final Offset position;

  TapPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        position, 10, paint); // Disegna un cerchio nel punto cliccato
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Rinfresca ogni volta
  }
}
