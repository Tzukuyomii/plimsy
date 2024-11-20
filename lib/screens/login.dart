import 'package:flutter/material.dart';
import 'package:plimsy/widgets/login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
        child: Center(
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
                  "assets/img/logos/white-logo.png",
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                const Expanded(
                  child: Login(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
