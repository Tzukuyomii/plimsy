import 'package:flutter/material.dart';
import 'package:plimsy/widgets/menus/menu_signal.dart';

class Signal extends StatelessWidget {
  const Signal({super.key});

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
        child: SafeArea(
          child: SizedBox(
            height: height,
            width: width,
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
                  child: Text(
                    "Work in progress...",
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.07),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
