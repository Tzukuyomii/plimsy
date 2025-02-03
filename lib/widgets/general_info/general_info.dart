import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plimsy/widgets/general_info/button_modal_contact_us.dart';
import 'package:plimsy/widgets/general_info/grid_info.dart';
import 'package:plimsy/widgets/general_info/pdf_viewer.dart';
import 'package:plimsy/widgets/general_info/radio_button.dart';

class GeneralInfo extends StatefulWidget {
  GeneralInfo(
      {super.key,
      required this.changeSize,
      required this.apiKey,
      required this.data,
      required this.controller,
      required this.onRadioButtonChanged,
      required this.selectedOption});

  String selectedOption;
  Function onRadioButtonChanged;
  TextEditingController controller;
  final Function changeSize;
  String apiKey;
  Map<String, dynamic> data;

  @override
  State<StatefulWidget> createState() {
    return _GeneralInfo();
  }
}

class _GeneralInfo extends State<GeneralInfo> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/img/logos/main-logo.png",
              width: width * 0.3,
            ),
            SizedBox(
              height: height * 0.4,
              width: width * 0.4,
              child: GridInfo(
                generalInformation: widget.data["generalInformation"],
                vesselHydrostaticData: widget.data["vesselHydrostaticData"],
              ),
            ),
            InkWell(
              onTap: () {
                widget.changeSize();
              },
              child: Image.asset(
                "assets/img/info-panel/go-back-icon.png",
                width: width * 0.07,
              ),
            )
          ],
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
                    Text(
                      "General Settings",
                      style: TextStyle(
                          fontSize: width * 0.015,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                        height:
                            height * 0.003), // Spazio tra il titolo e la linea
                    const Divider(color: Colors.white), // Linea sotto il titolo
                    SizedBox(
                        height: height *
                            0.03), // Spazio tra la linea e il primo input
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sea Water Density",
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'^\d*\.?\d{0,3}$')), // Solo numeri con massimo 3 decimali
                                ],
                                onChanged: (value) {
                                  double? numValue = double.tryParse(value);
                                  if (numValue != null) {
                                    if (numValue < 1.000) {
                                      widget.controller.text = "1.000";
                                    } else if (numValue > 1.200) {
                                      widget.controller.text = "1.200";
                                    }
                                    widget.controller.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                          offset:
                                              widget.controller.text.length),
                                    );
                                  }
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                textAlign: TextAlign.end,
                                controller: widget.controller,
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
                            SizedBox(
                              width: width * 0.002,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Force Heeling",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        RadioButton(
                          onRadioButtonChange: widget.onRadioButtonChanged,
                          selecteOption: widget.selectedOption,
                        )
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
                  ButtonModalContactUs(
                    apiKey: widget.apiKey,
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewerDialog(),
                        ),
                      )
                    },
                    child: Image.asset(
                      "assets/img/info-panel/help-icon.png",
                      width: width * 0.05,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
