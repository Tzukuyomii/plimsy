import 'package:flutter/material.dart';
import 'package:plimsy/dto/host.dart';
import 'package:plimsy/dto/user.dart';
import 'package:plimsy/models/content.dart';
import 'package:plimsy/screens/chooseVessel.dart';
import 'package:plimsy/screens/home.dart';
import 'package:plimsy/services/auth_service.dart';
import 'package:plimsy/services/host.dart';
import 'package:plimsy/util/secure_auth_storage.dart';
import 'package:plimsy/widgets/input_login.dart';
import 'package:plimsy/widgets/spinner/spinner_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  UserDTO? user;
  HostService hostService = HostService();
  Map<String, dynamic>? data;

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

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Home(
          user: user!,
          host: user!.hosts[0],
          data: data!,
        ), // Passa UserDTO alla schermata
      ),
    );

    spinner.hideSpinner();
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    final AuthService authService = AuthService();

    void accediButton() async {
      final spinner = context.read<SpinnerProvider>();

      try {
        spinner.showSpinner();
        // Ottieni il DTO dell'utente
        user = await authService.authenticate(
          usernameController.text,
          passwordController.text,
        );

        // Naviga in base alla lunghezza dell'array hosts
        if (user!.hosts.length <= 1) {
          _getHost(user!.hosts[0]);
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) =>
                  ChooseVessel(user: user!), // Passa UserDTO alla schermata
            ),
          );
          spinner.hideSpinner();
        }

        // Messaggio di successo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Benvenuto, ${user!.firstName} ${user!.lastName}!')),
        );
      } catch (e) {
        spinner.hideSpinner();

        // Mostra il messaggio di errore
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e')),
        );
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.25,
            child: InputLogin(
              textController: usernameController,
              labelText: 'Login Yacht',
              isPassword: false,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: height * 0.25,
            child: InputLogin(
              textController: passwordController,
              labelText: 'Password',
              isPassword: true,
            ),
          ),
          SizedBox(
            height: height * 0.3,
            child: TextButton(
              onPressed: accediButton,
              child: const Text(
                'Accedi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );
    });
  }
}
