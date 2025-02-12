import 'package:flutter/material.dart';
import 'package:plimsy/models/tank.dart';
import 'package:flutter/services.dart';
import 'package:plimsy/widgets/stability/liquids/liquid_painter.dart';

class SliderTank extends StatefulWidget {
  SliderTank(
      {super.key,
      required this.selectedTank,
      required this.selectColor,
      required this.tanksData,
      required this.updateTanks,
      required this.isPools,
      this.selectedTankId});

  String? selectedTankId;
  bool isPools;
  Function selectColor;
  Function updateTanks;
  String selectedTank;
  final Map<String, List<Tank>> tanksData; // Dati dinamici

  @override
  State<SliderTank> createState() {
    return _SliderTank();
  }
}

class _SliderTank extends State<SliderTank>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void logicPools(double value, Tank tank) {
    if (widget.selectedTankId != "") {
      // Ciclare i dati per trovare il tank con l'id selezionato
      Tank selectedTank = widget.tanksData.entries
          .where((entry) => entry.key == "POOL" || entry.key == "FRESH W.")
          .expand((entry) => entry.value)
          .firstWhere((tank) => tank.id == widget.selectedTankId);

      // Verifica che il tank selezionato abbia litri disponibili
      if (selectedTank.liters > 0 || value < tank.liters) {
        // Calcolare la differenza tra il nuovo valore dello slider e il valore attuale
        double difference = value - tank.liters;

        // Aggiungere una piccola tolleranza per evitare problemi di arrotondamento
        const double tolerance = 0.01;

        if (difference > 0) {
          // Se vuoi aumentare, verifica che il valore da aggiungere non superi i litri rimanenti nel tank selezionato
          if (selectedTank.liters >= difference - tolerance) {
            // Aggiorna i litri nel tank selezionato e nella piscina
            selectedTank.liters -= difference;
            tank.liters = value;
          } else {
            // Usa tutto ciò che resta nel tank selezionato
            tank.liters += selectedTank.liters;
            selectedTank.liters = 0;
          }
        } else if (difference < 0) {
          // Se stai diminuendo lo slider, i litri tolti dalla piscina tornano nel tank selezionato
          selectedTank.liters += -difference;
          tank.liters = value;
        }
      }
    }
  }

  void inputChangeManage(value, tank) {
    setState(() {
      final double? parsedValue = double.tryParse(value);
      if (parsedValue != null &&
          parsedValue >= 0 &&
          parsedValue <= tank.maxCapacity) {
        // Calcola tank.liters in base alla percentuale
        tank.liters = parsedValue;
      } else if (parsedValue != null && parsedValue < tank.maxCapacity) {
        tank.liters = 0;
      } else if (parsedValue != null && parsedValue > tank.maxCapacity) {
        tank.liters = tank.maxCapacity;
      }
    });
  }

  void inputChangePerManage(value, tank) {
    setState(() {
      final double? parsedValue = double.tryParse(value);
      if (parsedValue == null) {
        // Se il valore è vuoto, gestiscilo come un reset o un'azione predefinita

        inputChangePerManage(
            "0", tank); // Imposta il valore a 0% o a un valore predefinito
      }
      if (parsedValue != null && parsedValue >= 0 && parsedValue <= 100) {
        // Calcola tank.liters in base alla percentuale
        tank.liters = (parsedValue / 100) * tank.maxCapacity;
      } else if (parsedValue != null && parsedValue < 0) {
        tank.liters = 0;
      } else if (parsedValue != null && parsedValue > 100) {
        tank.liters = tank.maxCapacity;
      }
      if (widget.isPools) {
        // Se `isPools` è true, utilizza la logica per gestire le pools
        logicPools(parsedValue!, tank);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.selectColor(widget.selectedTank),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.tanksData[widget.selectedTank]!
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              Tank tank = entry.value;
              final TextEditingController percentageSliderCon =
                  TextEditingController(
                      text: ((tank.liters / tank.maxCapacity) * 100)
                          .toStringAsFixed(2));
              final TextEditingController litresSliderCon =
                  TextEditingController(text: tank.liters.toStringAsFixed(2));

              @override
              void dispose() {
                // Ricordati di liberare le risorse
                percentageSliderCon.dispose();
                litresSliderCon.dispose();
                super.dispose();
              }

              return Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.009),
                margin:
                    index != widget.tanksData[widget.selectedTank]!.length - 1
                        ? EdgeInsets.only(right: width * 0.01)
                        : EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Column(
                  children: [
                    Text(
                      "${tank.id} ${tank.prefix}",
                      style: TextStyle(
                          color: widget.selectColor(widget.selectedTank),
                          fontSize: width * 0.01,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("100%-",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.007)),
                                Text("50%-",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.007)),
                                Text("0%-",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.007)),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              // Contenitore esterno
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  width: width * 0.02,
                                  height: height * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 1.5), // Bordo contenitore
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AnimatedBuilder(
                                            animation: _controller,
                                            builder: (context, child) {
                                              return CustomPaint(
                                                painter: LiquidPainter(
                                                  _controller.value,
                                                  widget.selectColor(
                                                      widget.selectedTank),
                                                  double.tryParse(
                                                          percentageSliderCon
                                                              .text) ??
                                                      0.0,
                                                ),
                                                child: const SizedBox.expand(),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RotatedBox(
                            quarterTurns: -1,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 0.5,
                                thumbShape: LeftTriangleThumbShape(),
                                overlayShape: SliderComponentShape.noOverlay,
                                inactiveTrackColor:
                                    const Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                              child: Slider(
                                activeColor:
                                    widget.selectColor(widget.selectedTank),
                                value: tank.liters,
                                min: 0,
                                max: tank.maxCapacity,
                                divisions: 100,
                                onChanged: (double value) {
                                  setState(() {
                                    if (widget.isPools) {
                                      logicPools(value, tank);
                                    } else {
                                      tank.liters = value;
                                    }

                                    widget.updateTanks(widget.selectedTank,
                                        widget.tanksData[widget.selectedTank]!);
                                  });
                                },
                                label: tank.liters.round().toString(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: width * 0.035,
                          height: height * 0.025,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.end,
                            cursorColor: Colors.white,
                            style: TextStyle(
                                color: Colors.white, fontSize: width * 0.01),
                            controller: percentageSliderCon,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,

                              enabledBorder: OutlineInputBorder(
                                // Bordo visibile
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              filled: false, // Rimuove il background
                            ),
                            onSubmitted: (value) {
                              inputChangePerManage(value, tank);
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.002,
                        ),
                        Text(
                          "%",
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.0085),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: width * 0.045,
                          height: height * 0.025,
                          child: TextField(
                            textAlign: TextAlign.end,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.white, fontSize: width * 0.01),
                            controller: litresSliderCon,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,

                              enabledBorder: OutlineInputBorder(
                                // Bordo visibile
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              filled: false, // Rimuove il background
                            ),
                            onSubmitted: (value) {
                              if (widget.isPools) {
                                final doubleValue = double.tryParse(value);
                                logicPools(doubleValue!, tank);
                              } else {
                                inputChangeManage(value, tank);
                              }

                              widget.updateTanks(widget.selectedTank,
                                  widget.tanksData[widget.selectedTank]!);
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.002,
                        ),
                        Text(
                          "lt.",
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.0085),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }).toList()),
      ),
    );
  }
}

class LeftTriangleThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // Definisce la dimensione della thumb
    return const Size(20, 25);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()..color = sliderTheme.thumbColor ?? Colors.blue;

    // Disegna un triangolo con vertice a sinistra
    final Path trianglePath = Path()
      ..moveTo(center.dx, center.dy - 10) // Punta del triangolo (a sinistra)
      ..lineTo(center.dx - 5, center.dy + 10) // Angolo in alto a destra
      ..lineTo(center.dx + 5, center.dy + 10) // Angolo in basso a destra
      ..close();

    canvas.drawPath(trianglePath, paint);
  }
}
