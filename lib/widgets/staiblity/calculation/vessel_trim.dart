import 'package:flutter/material.dart';

class VesselTrim extends StatefulWidget {
  const VesselTrim({super.key});
  @override
  State<VesselTrim> createState() {
    return _VesselTrim();
  }
}

class _VesselTrim extends State<VesselTrim> {
  final double _trimValue = 0;
  final double _heelValue = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/calculations-main/trim-icon(placeholder).png",
                    width: width * 0.2,
                  ),
                  Container(
                    width: double.infinity,
                    height:
                        height * 0.03, // Altezza del container con gradiente
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment
                            .topCenter, // Partenza del gradiente in basso
                        end: Alignment
                            .bottomCenter, // Fine del gradiente in alto
                        colors: [
                          Color.fromARGB(
                              255, 136, 137, 138), // Colore intenso in basso
                          Color.fromARGB(
                              0, 110, 110, 110), // Colore trasparente in alto
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Trim',
                        style: TextStyle(
                          fontSize: width * 0.0099,
                          color: Colors.white, // Colore del testo
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          color: _trimValue < 0
                              ? const Color.fromARGB(255, 248, 18, 1)
                              : Colors.grey,
                          size: width * 0.03,
                        ),
                        Text(
                          "$_trimValue",
                          style: TextStyle(
                            fontSize: width * 0.0099,
                            color: Colors.white, // Colore del testo
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: _trimValue > 0
                              ? const Color.fromARGB(255, 248, 18, 1)
                              : Colors.grey,
                          size: width * 0.03,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: height *
                                0.065, // Altezza del container con gradiente
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment
                                    .topCenter, // Partenza del gradiente in basso
                                end: Alignment
                                    .bottomCenter, // Fine del gradiente in alto
                                colors: [
                                  Color.fromARGB(255, 136, 137,
                                      138), // Colore intenso in basso
                                  Color.fromARGB(0, 114, 114,
                                      114), // Colore trasparente in alto
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img/calculations-main/heel-icon.png",
                              width: width * 0.05,
                            ),
                            Text(
                              "Heel",
                              style: TextStyle(
                                fontSize: width * 0.0099,
                                color: Colors.white, // Colore del testo
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.rotate(
                        angle: 0.5 * 3.14159,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: _heelValue < 0
                              ? const Color.fromARGB(255, 248, 18, 1)
                              : Colors.grey,
                          size: width * 0.03,
                        ),
                      ),
                      Text(
                        "$_heelValue",
                        style: TextStyle(
                          fontSize: width * 0.0099,
                          color: Colors.white, // Colore del testo
                        ),
                      ),
                      Transform.rotate(
                        angle: 1.5 * 3.14159, // Rotate 270 degrees (pi/2 * 3)
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: _heelValue > 0
                              ? const Color.fromARGB(255, 248, 18, 1)
                              : Colors.grey,
                          size: width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "AFT MARK PT",
                            style: TextStyle(
                              fontSize: width * 0.0075,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                          Text(
                            "-",
                            style: TextStyle(
                              fontSize: width * 0.0075,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "FWD MARK PT",
                            style: TextStyle(
                              fontSize: width * 0.0075,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                          Text(
                            "-",
                            style: TextStyle(
                              fontSize: width * 0.0075,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "-",
                              style: TextStyle(
                                fontSize: width * 0.0075,
                                color: Colors.white, // Colore del testo
                              ),
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                fontSize: width * 0.0075,
                                color: Colors.white, // Colore del testo
                              ),
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                fontSize: width * 0.0075,
                                color: Colors.white, // Colore del testo
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          "assets/img/calculations-main/top-wpa-icon.png",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "AFT MARK SB",
                            style: TextStyle(
                              fontSize: width * 0.0075,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                          Text(
                            "-",
                            style: TextStyle(
                              fontSize: width * 0.0075,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "FWD MARK SB",
                            style: TextStyle(
                              fontSize: width * 0.0075,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                          Text(
                            "-",
                            style: TextStyle(
                              fontSize: width * 0.0075,
                              color: Colors.white, // Colore del testo
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
