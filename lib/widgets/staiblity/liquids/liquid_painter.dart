import 'package:flutter/material.dart';
import 'dart:math';

class LiquidPainter extends CustomPainter {
  LiquidPainter(this.animationValue, this.tankcolor, this.fillPercentage);

  final double animationValue;
  double fillPercentage;
  Color tankcolor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = tankcolor;
    double waveHeight = 2.0;
    double baseHeight = size.height *
        (1 - (fillPercentage / 100)); // Altezza del liquido statico

    Path path = Path();
    path.moveTo(0, baseHeight);

    // Crea un'onda sinusoidale
    for (double i = 0; i <= size.width; i++) {
      double y = sin((i / size.width * 2 * pi) + (animationValue * 2 * pi)) *
              waveHeight +
          baseHeight;
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
