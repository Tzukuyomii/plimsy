import 'package:flutter/material.dart';

class Wind extends StatefulWidget {
  const Wind({super.key});
  @override
  State<Wind> createState() {
    return _Wind();
  }
}

class _Wind extends State<Wind> {
  double _rotationAngle = 0.0; // Angolo di rotazione in radianti
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // Non dimenticare di liberare il controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ruota fissa con i numeri
              CustomPaint(
                size:
                    Size(width * 0.05, height * 0.05), // Dimensione della ruota
                painter: FixedDegreeWheelPainter(),
              ),
              // Indicatore che ruota
              Transform.rotate(
                angle: _rotationAngle,
                child: CustomPaint(
                  size: Size(width * 0.05, height * 0.05),
                  painter: RotatingIndicatorPainter(),
                ),
              ),
              // Immagine della barca al centro
              Image.asset(
                'assets/img/calculations-main/yacht-top-icon.png', // Sostituisci con il file della barca
                width: width * 0.05,
                height: height * 0.05,
              ),
              // Interazione per ruotare
              GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _rotationAngle += details.delta.dx * 0.01;
                  });
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              "Wind Incidence: ${_rotationAngle.toStringAsFixed(2)}°",
              style: TextStyle(color: Colors.white, fontSize: width * 0.0085),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Wind Velocity:",
                  style:
                      TextStyle(color: Colors.white, fontSize: width * 0.0085),
                ),
                SizedBox(
                  width: width * 0.005,
                ),
                SizedBox(
                  width: width * 0.035,
                  height: height * 0.025,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.end,
                    cursorColor: Colors.white,
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.01),
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,

                      enabledBorder: OutlineInputBorder(
                        // Bordo visibile
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 1.0)),
                      filled: false, // Rimuove il background
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.005,
                ),
                Text(
                  "knots",
                  style:
                      TextStyle(color: Colors.white, fontSize: width * 0.0085),
                )
              ],
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                minimumSize: Size(width * 0.01, height * 0.01),
                side: const BorderSide(color: Colors.white, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Calc",
                style: TextStyle(color: Colors.white, fontSize: width * 0.0085),
              ),
            )
          ],
        ),
      ],
    );
  }
}

// CustomPainter per disegnare la ruota fissa con i numeri
class FixedDegreeWheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Disegna il cerchio esterno
    final circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(center, radius, circlePaint);

    // Disegna i numeri attorno al cerchio
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Gradi e le loro posizioni
    final List<MapEntry<int, Offset>> degreeOffsets = [
      const MapEntry(0, Offset(0, -1)), // Nord
      const MapEntry(45, Offset(0.707, -0.707)), // Nord-Est
      const MapEntry(90, Offset(1, 0)), // Est
      const MapEntry(45, Offset(0.707, 0.707)), // Sud-Est
      const MapEntry(180, Offset(0, 1)), // Sud
      const MapEntry(-45, Offset(-0.707, 0.707)), // Sud-Ovest
      const MapEntry(-90, Offset(-1, 0)), // Ovest
      const MapEntry(-45, Offset(-0.707, -0.707)), // Nord-Ovest
    ];

    degreeOffsets.forEach((entry) {
      final degree = entry.key;
      final offset = entry.value;

      final x = center.dx + (radius + 15) * offset.dx;
      final y = center.dy + (radius + 15) * offset.dy;

      final textSpan = TextSpan(
        text: degree == 180 ? "0" : degree.toString(), // Mostra "0" anche a Sud
        style: const TextStyle(color: Colors.white, fontSize: 12),
      );
      textPainter.text = textSpan;
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// CustomPainter per disegnare l'indicatore che ruota
class RotatingIndicatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.3;

    final indicatorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Disegna un indicatore (freccia) con la base sul cerchio
    final path = Path();

    // Punto base sinistro della freccia (sul bordo del cerchio)
    final baseLeft = Offset(center.dx - 5, center.dy - radius - 5);

    // Punto base destro della freccia (sul bordo del cerchio)
    final baseRight = Offset(center.dx + 5, center.dy - radius - 5);

    // Punta della freccia (rivolta verso il centro della barca)
    final tip = Offset(center.dx, center.dy - radius + 5);

    // Costruzione del triangolo
    path.moveTo(baseLeft.dx, baseLeft.dy); // Punto sinistro della base
    path.lineTo(baseRight.dx, baseRight.dy); // Punto destro della base
    path.lineTo(tip.dx, tip.dy); // Punta della freccia
    path.close();

    canvas.drawPath(path, indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
