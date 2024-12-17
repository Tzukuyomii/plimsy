import 'package:flutter/material.dart';
import 'package:plimsy/widgets/staiblity/fixed/fixed_accordion.dart';

class Fixed extends StatefulWidget {
  const Fixed({super.key});

  @override
  State<Fixed> createState() {
    return _Fixed();
  }
}

class _Fixed extends State<Fixed> with TickerProviderStateMixin {
  Offset? _tapPosition; // Per tracciare il punto del click
  String _dropdownValue = 'main-deck'; // Valore iniziale del menu a tendina
  final TransformationController _transformationController =
      TransformationController(); // Controller per trasformazioni

  String _getImageForSelectedOption() {
    switch (_dropdownValue) {
      case 'main-deck':
        return 'assets/img/fixed-dw-ga/main-deck.png'; // Sostituisci con i tuoi percorsi
      case 'lower-deck':
        return 'assets/img/fixed-dw-ga/lower-deck.png';
      case 'observation-deck':
        return 'assets/img/fixed-dw-ga/observation-deck.png';
      default:
        return 'assets/img/fixed-dw-ga/upper-deck.png'; // Immagine di default
    }
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
                      image: AssetImage(
                        _getImageForSelectedOption(),
                      ), // Immagine dinamica
                      fit: BoxFit.contain,
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
                    items: <String>[
                      'main-deck',
                      'lower-deck',
                      'observation-deck'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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
