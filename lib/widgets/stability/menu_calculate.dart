import 'package:flutter/material.dart';
import 'package:plimsy/widgets/stability/trapezoid_painter.dart';

class MenuCalculate extends StatefulWidget {
  MenuCalculate(
      {super.key,
      required this.showContent,
      required this.draft,
      required this.firstDraft,
      required this.intactService,
      required this.draftUpdated});

  bool draftUpdated;
  bool firstDraft;
  String showContent;
  Function draft;
  Function intactService;

  @override
  State<MenuCalculate> createState() {
    return _MenuCalculate();
  }
}

class _MenuCalculate extends State<MenuCalculate>
    with TickerProviderStateMixin {
  late AnimationController _controllerDraft;
  late Animation<double> _animationDraft;
  late AnimationController _controllerIntact;
  late Animation<double> _animationIntact;

  @override
  void initState() {
    super.initState();

    // Inizializza l'AnimationController e l'animazione di scala
    _controllerDraft = AnimationController(
      duration: const Duration(milliseconds: 100), // Velocità dell'animazione
      vsync: this,
    );
    // Inizializza l'AnimationController e l'animazione di scala
    _controllerIntact = AnimationController(
      duration: const Duration(milliseconds: 100), // Velocità dell'animazione
      vsync: this,
    );

    // L'animazione scala da 1 (dimensione originale) a 0.95 (leggermente ridotto)
    _animationDraft =
        Tween<double>(begin: 1.0, end: 0.95).animate(_controllerDraft);
    _animationIntact =
        Tween<double>(begin: 1.0, end: 0.95).animate(_controllerIntact);
  }

  @override
  void dispose() {
    _controllerDraft
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
          InkWell(
            onTapDown: (_) {
              _controllerDraft.forward(); // Esegue l'animazione di pressione
            },
            onTapUp: (_) {
              _controllerDraft
                  .reverse(); // Ritorna alla dimensione normale al rilascio del tap
            },
            onTapCancel: () {
              _controllerDraft
                  .reverse(); // Se l'utente annulla il tap, ripristina l'animazione
            },
            onTap: () {
              widget.draft();
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: ScaleTransition(
              scale: _animationDraft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/calculations-main/draft-icon.png",
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
          SizedBox(
            width: width * 0.02,
          ),
          Opacity(
            opacity: !widget.firstDraft || !widget.draftUpdated ? 0.5 : 1,
            child: InkWell(
              onTapDown: (_) {
                _controllerIntact.forward(); // Esegue l'animazione di pressione
              },
              onTapUp: (_) {
                _controllerIntact
                    .reverse(); // Ritorna alla dimensione normale al rilascio del tap
              },
              onTapCancel: () {
                _controllerIntact
                    .reverse(); // Se l'utente annulla il tap, ripristina l'animazione
              },
              onTap: !widget.firstDraft || !widget.draftUpdated
                  ? null
                  : () {
                      widget.intactService();
                    },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: ScaleTransition(
                scale: _animationIntact,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/calculations-main/stability-icon.png",
                      width: width * 0.025,
                    ),
                    const Text(
                      "Intact",
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
