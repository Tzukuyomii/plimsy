import 'package:flutter/material.dart';

class TrapezoidBorderPainter extends CustomPainter {
  final Color borderColor;

  TrapezoidBorderPainter(this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Imposta la larghezza del bordo

    final Path path = Path()
      // Partiamo dal punto in basso a sinistra
      ..moveTo(0, size.height)
      // Tracciamo il lato sinistro del trapezio (base più larga)
      ..lineTo(size.width * 0.2, size.height - 1) // Spostiamo la base sinistra
      // Tracciamo il lato destro del trapezio (base più stretta)
      ..lineTo(size.width * 0.8, size.height - 1) // Spostiamo la base destra
      // Completiamo con la parte inferiore (basso a destra)
      ..lineTo(size.width, size.height)
      ..close(); // Chiudiamo il path

    canvas.drawPath(path, paint); // Disegniamo il path sul canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
