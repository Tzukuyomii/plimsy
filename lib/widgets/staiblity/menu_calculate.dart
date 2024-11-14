import 'package:flutter/material.dart';

class MenuCalculate extends StatefulWidget {
  MenuCalculate(
      {super.key, required this.changeContent, required this.showContent});

  String showContent;
  Function changeContent;

  @override
  State<MenuCalculate> createState() {
    return _MenuCalculate();
  }
}

class _MenuCalculate extends State<MenuCalculate>
    with TickerProviderStateMixin {
  late AnimationController _controllerCalculate;
  late Animation<double> _animationCalculate;

  @override
  void initState() {
    super.initState();

    // Inizializza l'AnimationController e l'animazione di scala
    _controllerCalculate = AnimationController(
      duration: const Duration(milliseconds: 100), // Velocità dell'animazione
      vsync: this,
    );

    // L'animazione scala da 1 (dimensione originale) a 0.95 (leggermente ridotto)
    _animationCalculate =
        Tween<double>(begin: 1.0, end: 0.95).animate(_controllerCalculate);
  }

  @override
  void dispose() {
    _controllerCalculate
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
                  color: widget.showContent == "Draft"
                      ? Colors.black
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: InkWell(
              onTapDown: (_) {
                _controllerCalculate
                    .forward(); // Esegue l'animazione di pressione
              },
              onTapUp: (_) {
                _controllerCalculate
                    .reverse(); // Ritorna alla dimensione normale al rilascio del tap
              },
              onTapCancel: () {
                _controllerCalculate
                    .reverse(); // Se l'utente annulla il tap, ripristina l'animazione
              },
              onTap: () {
                widget.changeContent("Draft");
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: ScaleTransition(
                scale: _animationCalculate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/calculations-main/loadline-status.png",
                      width: width * 0.025,
                    ),
                    const Text(
                      "Draft",
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
