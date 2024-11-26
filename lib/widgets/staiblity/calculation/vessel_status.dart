import 'package:flutter/material.dart';

class VesselStatus extends StatefulWidget {
  const VesselStatus({super.key});
  @override
  State<VesselStatus> createState() {
    return _VesselStatus();
  }
}

class _VesselStatus extends State<VesselStatus> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: CustomPaint(
                size: Size(width * 0.09,
                    height * 0.07), // Dimensioni della barra semicircolare
                painter: SemicircleBorderPainter(),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/img/calculations-main/icon-status-waiting.png",
              ),
            ),
          ],
        ),
        Text(
          "- Please asses the draft of the vessel",
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.01,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class SemicircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Colore del bordo del semicerchio
      ..style = PaintingStyle.stroke // Solo il bordo
      ..strokeWidth = 5.0; // Spessore del bordo

    // Rettangolo che definisce la dimensione dell'arco
    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    // Disegna il semicerchio superiore (bordo)
    canvas.drawArc(rect, 3.14, 3.14, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
