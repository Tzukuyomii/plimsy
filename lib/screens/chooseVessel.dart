import 'package:flutter/material.dart';
import 'package:plimsy/dto/host.dart';
import 'package:plimsy/dto/user.dart';
import 'package:plimsy/models/content.dart';
import 'package:plimsy/screens/home.dart';
import 'package:plimsy/services/host.dart';
import 'package:plimsy/util/secure_auth_storage.dart';
import 'package:plimsy/widgets/spinner/spinner_overlay.dart';
import 'package:plimsy/widgets/spinner/spinner_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ChooseVessel extends StatefulWidget {
  ChooseVessel({super.key, required this.user});

  UserDTO user;

  @override
  State<ChooseVessel> createState() {
    return _ChooseVessel();
  }
}

class _ChooseVessel extends State<ChooseVessel> {
  HostService hostService = HostService();
  Map<String, dynamic>? data;
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    void _getHost(HostDTO selectedHost) async {
      final spinner = context.read<SpinnerProvider>();

      spinner.showSpinner();

      // Recupera gli assets salvati.
      final assets = await SecureAuthStorage.getAssets();

      // Prepara il contenuto basandoti sugli assets.
      final body =
          assets != null ? Map<String, String>.from(json.decode(assets)) : {};

      // Valorizza l'oggetto content.
      Content content = Content(
        request: "connection",
        body: body,
      );

      // Avvia il servizio host.

      data = await hostService.host(selectedHost.apiKey, content);

      spinner.hideSpinner();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => Home(
            user: widget.user,
            host: selectedHost,
            data: data!,
          ),
        ),
      );
    }

    void accediButton() async {
      if (selectedItem != null) {
        final selectedHost = widget.user.hosts.firstWhere(
          (host) => host.description == selectedItem,
          orElse: () => throw Exception("Host non trovato"),
        );

        _getHost(selectedHost);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Seleziona un'imbarcazione!"),
              actions: [
                TextButton(
                  onPressed: () async {
                    SecureAuthStorage.clearStorage();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Chiudi'),
                ),
              ],
            );
          },
        );
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(134, 1, 200, 235),
                  Color.fromARGB(122, 9, 110, 150),
                  Color.fromARGB(177, 1, 42, 117)
                ],
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    left: 5,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(1, 86, 118, 0.8),
                      radius: 30,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(1, 86, 118, 0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: width * 0.7,
                      height: height * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/img/logos/main-logo.png",
                            width: width * 0.3,
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      value: selectedItem,
                                      hint: const Text(
                                          "Seleziona un'imbarcazione "),
                                      items: widget.user.hosts.map((host) {
                                        return DropdownMenuItem<String>(
                                          value: host.description,
                                          child: Text(host.description),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedItem = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: accediButton,
                                  child: const Text(
                                    "Seleziona",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SpinnerOverlay(),
        ],
      ),
    );
  }
}
