import 'package:flutter/material.dart';
import 'package:plimsy/models/content.dart';
import 'package:plimsy/services/contact_us.dart';
import 'package:plimsy/widgets/general_info/custom_radio_buttons.dart';
import 'package:plimsy/widgets/general_info/custom_text_field.dart';
import 'package:plimsy/models/form_model.dart';
import 'package:plimsy/widgets/spinner/spinner_overlay.dart';
import 'package:plimsy/widgets/spinner/spinner_provider.dart';
import 'package:provider/provider.dart';

class ButtonModalContactUs extends StatefulWidget {
  ButtonModalContactUs({super.key, required this.apiKey});

  String apiKey;
  @override
  State<StatefulWidget> createState() {
    return _ButtonModalContactUs();
  }
}

class _ButtonModalContactUs extends State<ButtonModalContactUs> {
  ContactUs contactUs = ContactUs();
  FormModel form = FormModel(requestType: "ask", email: "", description: "");
  bool _isEmailValid = false; // Stato per gestire la validità dell'email

  void sendForm() async {
    Content content = Content(request: "form-request", body: form);
    final spinner = context.read<SpinnerProvider>();
    if (_isEmailValid) {
      spinner.showSpinner();
      final response = await contactUs.contactUs(widget.apiKey, content);

      // Messaggio di successo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response["res"]["message"]}')),
      );
      spinner.hideSpinner();
      _isEmailValid = false;
      Navigator.pop(context);
    } else {
      spinner.hideSpinner();
      // Messaggio di successo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email non valida')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: [
              AlertDialog(
                backgroundColor: const Color.fromRGBO(59, 103, 141, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(width * 0.025),
                content: SizedBox(
                  height: height * 0.7,
                  width: width * 0.4, // Larghezza della modale
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/img/info-panel/contact-us-icon.png",
                            width: width * 0.05,
                          ),
                          Column(
                            children: [
                              Text(
                                "Select your request:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.01,
                                    color: Colors.white),
                              ),
                              CustomRadioButtons(
                                onChanged: (value) {
                                  setState(() {
                                    form.requestType = value;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your email:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.01,
                                  color: Colors.white),
                            ),
                          ),
                          CustomTextField(
                            isEmail: true,
                            onChanged: (value) {
                              setState(() {
                                form.email = value;
                                _isEmailValid = RegExp(
                                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(it|com)$")
                                    .hasMatch(value);
                                print("VALIDATE $_isEmailValid");
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.01,
                                  color: Colors.white),
                            ),
                          ),
                          CustomTextField(
                            isEmail: false,
                            onChanged: (value) {
                              setState(() {
                                form.description = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red, // Colore di sfondo rosso
                              foregroundColor:
                                  Colors.white, // Colore del testo bianco
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Bordi smussati
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.01,
                                  color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  Colors.white, // Colore del testo bianco
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Bordi smussati
                              ),
                            ),
                            onPressed: () {
                              sendForm();
                            },
                            child: Text(
                              'Send',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.01,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SpinnerOverlay()
            ],
          );
        },
      ),
      child: Image.asset(
        "assets/img/info-panel/contact-us-icon.png",
        width: width * 0.05,
      ),
    );
  }
}
