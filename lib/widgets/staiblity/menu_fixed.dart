import 'package:flutter/material.dart';

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
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.showContent == "Fixed"
                      ? Colors.black
                      : Colors.transparent,
                  width: 2,
                ),
              ),
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
