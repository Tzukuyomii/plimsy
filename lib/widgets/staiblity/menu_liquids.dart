import 'package:flutter/material.dart';
import 'package:plimsy/widgets/staiblity/trapezoid_painter.dart';

class MenuLiquids extends StatefulWidget {
  MenuLiquids(
      {super.key, required this.changeContent, required this.showContent});

  String showContent;
  Function changeContent;

  @override
  State<StatefulWidget> createState() {
    return _MenuLiquids();
  }
}

class _MenuLiquids extends State<MenuLiquids> with TickerProviderStateMixin {
  late AnimationController _controllerTanks;
  late AnimationController _controllerPools;
  late Animation<double> _animationTanks;
  late Animation<double> _animationPools;

  @override
  void initState() {
    super.initState();

    // Inizializza l'AnimationController e l'animazione di scala
    _controllerTanks = AnimationController(
      duration: const Duration(milliseconds: 100), // Velocità dell'animazione
      vsync: this,
    );
    _controllerPools = AnimationController(
      duration: const Duration(milliseconds: 100), // Velocità dell'animazione
      vsync: this,
    );

    // L'animazione scala da 1 (dimensione originale) a 0.95 (leggermente ridotto)
    _animationTanks =
        Tween<double>(begin: 1.0, end: 0.95).animate(_controllerTanks);
    _animationPools =
        Tween<double>(begin: 1.0, end: 0.95).animate(_controllerPools);
  }

  @override
  void dispose() {
    _controllerTanks
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
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: width * 0.02,
          ),
          CustomPaint(
            painter: TrapezoidBorderPainter(
              widget.showContent == "Tanks"
                  ? Colors.yellow
                  : Colors.transparent,
            ),
            child: InkWell(
              onTapDown: (_) {
                _controllerTanks.forward(); // Esegue l'animazione di pressione
              },
              onTapUp: (_) {
                _controllerTanks
                    .reverse(); // Ritorna alla dimensione normale al rilascio del tap
              },
              onTapCancel: () {
                _controllerTanks
                    .reverse(); // Se l'utente annulla il tap, ripristina l'animazione
              },
              onTap: () {
                widget.changeContent("Tanks");
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: ScaleTransition(
                scale: _animationTanks,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/tanks-page/tanks-icon.png",
                      width: width * 0.025,
                    ),
                    const Text(
                      "Tanks",
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
          SizedBox(
            width: width * 0.01,
          ),
          CustomPaint(
            painter: TrapezoidBorderPainter(
              widget.showContent == "Pools"
                  ? Colors.yellow
                  : Colors.transparent,
            ),
            child: InkWell(
              onTapDown: (_) {
                _controllerPools.forward(); // Esegue l'animazione di pressione
              },
              onTapUp: (_) {
                _controllerPools
                    .reverse(); // Ritorna alla dimensione normale al rilascio del tap
              },
              onTapCancel: () {
                _controllerPools
                    .reverse(); // Se l'utente annulla il tap, ripristina l'animazione
              },
              onTap: () {
                widget.changeContent("Pools");
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: ScaleTransition(
                scale: _animationPools,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/tanks-page/pools-icon.png",
                      width: width * 0.025,
                    ),
                    const Text(
                      "Pools",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
