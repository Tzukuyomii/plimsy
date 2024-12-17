import 'package:flutter/material.dart';
import 'package:plimsy/dto/user.dart';
import 'package:plimsy/screens/chooseVessel.dart';
import 'package:plimsy/screens/home.dart';
import 'package:plimsy/services/auth_service.dart';
import 'package:plimsy/widgets/input_login.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    final AuthService authService = AuthService();

    void accediButton() async {
      try {
        // Ottieni il DTO dell'utente
        final UserDTO user = await authService.authenticate(
          usernameController.text,
          passwordController.text,
        );
        // Naviga in base alla lunghezza dell'array hosts
        if (user.hosts.length > 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => Home(
                user: user,
                host: user.hosts[0],
              ), // Passa UserDTO alla schermata
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) =>
                  ChooseVessel(user: user), // Passa UserDTO alla schermata
            ),
          );
        }

        // Messaggio di successo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Benvenuto, ${user.firstName} ${user.lastName}!')),
        );
      } catch (e) {
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
