import 'package:flutter/material.dart';
import 'package:plimsy/screens/chooseVessel.dart';
import 'package:plimsy/screens/home.dart';
import 'package:plimsy/widgets/input_login.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    void accediButton() {
      print(usernameController.text);
      if (usernameController.text == "GiovanniR") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ChooseVessel(),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const Home(),
          ),
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
