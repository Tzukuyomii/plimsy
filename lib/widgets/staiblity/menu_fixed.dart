import 'package:flutter/material.dart';
import 'package:plimsy/widgets/staiblity/trapezoid_painter.dart';

class MenuFixed extends StatefulWidget {
  MenuFixed(
      {super.key, required this.changeContent, required this.showContent});

  String showContent;
  Function changeContent;
  @override
  State<MenuFixed> createState() {
    return _MenuFixed();
  }
}

class _MenuFixed extends State<MenuFixed> with TickerProviderStateMixin {
  late AnimationController _controllerFixed;
  late Animation<double> _animationFixed;

  @override
  void initState() {
    super.initState();

    // Inizializza l'AnimationController e l'animazione di scala
    _controllerFixed = AnimationController(
      duration: const Duration(milliseconds: 100), // Velocità dell'animazione
      vsync: this,
    );

    // L'animazione scala da 1 (dimensione originale) a 0.95 (leggermente ridotto)
    _animationFixed =
        Tween<double>(begin: 1.0, end: 0.95).animate(_controllerFixed);
  }

  @override
  void dispose() {
    _controllerFixed
        .dispose(); // Disattiva il controller per prevenire memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.02,
          ),
          CustomPaint(
            painter: TrapezoidBorderPainter(
              widget.showContent == "Fixed"
                  ? Colors.yellow
                  : Colors.transparent,
            ),
            child: InkWell(
              onTapDown: (_) {
                _controllerFixed.forward(); // Esegue l'animazione di pressione
              },
              onTapUp: (_) {
                _controllerFixed
                    .reverse(); // Ritorna alla dimensione normale al rilascio del tap
              },
              onTapCancel: () {
                _controllerFixed
                    .reverse(); // Se l'utente annulla il tap, ripristina l'animazione
              },
              onTap: () {
                widget.changeContent("Fixed");
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: ScaleTransition(
                scale: _animationFixed,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/solid-weights/fixedweights.png",
                      width: width * 0.025,
                    ),
                    const Text(
                      "Fixed",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 2); // Inizia dall'angolo in basso a sinistra
    path.lineTo(
        size.width * 0.1, size.height); // Crea il primo angolo del trapezio
    path.lineTo(
        size.width * 0.9, size.height); // Crea il secondo angolo del trapezio
    path.lineTo(size.width, size.height - 2); // Angolo in basso a destra
    path.lineTo(size.width, 0); // Torna in alto a destra
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
