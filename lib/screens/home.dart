import 'package:flutter/material.dart';
import 'package:plimsy/widgets/menus/container_menu.dart';
import 'package:plimsy/widgets/general_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  bool isDialogOpen = true;

  void _setDialogState(bool isOpen) {
    setState(() {
      isDialogOpen = isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isDialogOpen)
                      const ContainerMenu(
                        isLogin: false,
                      ),
                  ],
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GeneralInfo(
                    onDialogOpenChange: _setDialogState,
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
