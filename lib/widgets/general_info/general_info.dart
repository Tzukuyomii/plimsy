import 'package:flutter/material.dart';
import 'package:plimsy/widgets/general_info/grid_info.dart';
import 'package:plimsy/widgets/general_info/radio_button.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({super.key, required this.changeSize});

  final Function changeSize;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController _controller =
        TextEditingController(text: "1.025");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/img/logos/white-logo.png",
                width: width * 0.3,
              ),
              SizedBox(
                height: height * 0.4,
                width: width * 0.4,
                child: const GridInfo(),
              ),
              InkWell(
                onTap: () {
                  changeSize();
                },
                child: Image.asset(
                  "assets/img/info-panel/go-back-icon.png",
                  width: 100,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white, width: 1), // Bordo del contenitore
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "General Settings",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                        height: 8), // Spazio tra il titolo e la linea
                    const Divider(color: Colors.white), // Linea sotto il titolo
                    const SizedBox(
                        height: 16), // Spazio tra la linea e il primo input
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sea Wateer Density",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width * 0.15,
                              height: height * 0.05,
                              child: TextField(
                                textAlign: TextAlign.end,
                                controller: _controller,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // Bordo smussato quando in focus
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .blue, // Colore del bordo in focus
                                        width:
                                            2, // Larghezza del bordo in focus
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // Bordo smussato quando abilitato
                                      borderSide: BorderSide(
                                        color: Colors.grey
                                            .shade400, // Colore del bordo abilitato
                                        width:
                                            1, // Larghezza del bordo abilitato
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, right: 4)),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "t/m³",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                        height: 16), // Spazio tra l'input e la sezione radio
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Force Heeling",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        RadioButton()
                      ],
                    ),
                    const SizedBox(
                        height: 16), // Spazio tra le radio e il pulsante
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // Azione da eseguire quando il pulsante viene premuto
                          },
                          child: const Text(
                            "Check Update",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Text(
                          "Current Version 1.0.0",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/img/info-panel/contact-us-icon.png"),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Image.asset("assets/img/info-panel/help-icon.png"),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
