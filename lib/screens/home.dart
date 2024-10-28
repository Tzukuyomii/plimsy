import 'package:flutter/material.dart';
import 'package:plimsy/widgets/menus/container_menu.dart';
import 'package:plimsy/widgets/general_info/general_info_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _Home();
  }
}

class _Home extends State<Home> with TickerProviderStateMixin {
  bool isOpen = false;
  bool showContent = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // AnimationController per gestire le animazioni.
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Definizione dell'animazione di opacità.
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    if (isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  void changeSize() {
    if (isOpen) {
      // Se il menu è aperto, nascondi il contenuto espanso con fade-out e riduci
      _controller.reverse().then((_) {
        setState(() {
          showContent = false;
          isOpen = false;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          _controller.forward();
        });
      });
    } else {
      // Se il menu è chiuso, nascondi il contenuto ridotto con fade-out e espandi
      _controller.reverse().then((_) {
        setState(() {
          isOpen = true;
          showContent = true;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          _controller.forward().then((_) {});
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double containerWidth() {
      return isOpen ? width * 0.8 : width * 0.5;
    }

    double containerHeight() {
      return isOpen ? height * 0.8 : height * 0.2;
    }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerMenu(
                      containerHeight: containerHeight(),
                      containerWidth: containerWidth(),
                      isOpen: isOpen,
                      fadeAnimation: _fadeAnimation,
                      showContent: showContent,
                      onDialogOpenChange: changeSize,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GeneralInfoContainer(
                    onDialogOpenChange: changeSize,
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
