import 'package:flutter/material.dart';
import 'package:plimsy/widgets/general_info/label.dart';
import 'package:plimsy/widgets/staiblity/menu_calculate.dart';
import 'package:plimsy/widgets/staiblity/menu_fixed.dart';
import 'package:plimsy/widgets/staiblity/menu_liquids.dart';

class MenuStability extends StatefulWidget {
  MenuStability({super.key, required this.changeContent});

  Function changeContent;

  @override
  State<MenuStability> createState() {
    return _MenuStability();
  }
}

class _MenuStability extends State<MenuStability>
    with TickerProviderStateMixin {
  String showSecondMenu = "";

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Imposta l'AnimationController per l'animazione di scorrimento
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Da destra all'interno della Row
      end: Offset.zero, // Arriva alla posizione normale
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void changeTabMenu(value) {
    setState(() {
      if (value == showSecondMenu) {
        showSecondMenu = "";
        _controller.reverse();
      } else if (value == "fixed") {
        showSecondMenu = "fixed";
        _controller.forward();
      } else if (value == "calculate") {
        showSecondMenu = "calculate";
        _controller.forward();
      } else if (value == "liquids") {
        showSecondMenu = "liquids";
        _controller.forward();
      } else {
        showSecondMenu = "";
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        AppBar(
          leading: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/img/main/home.png",
            ),
          ),
          toolbarHeight: height * 0.1,
          backgroundColor: const Color.fromRGBO(1, 57, 75, 0.6),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/img/main/stability-icon.png',
                    width: width * 0.03,
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "S",
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "tability",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              "assets/img/nav-icon/liquid-weights.png",
                              width: width * 0.045,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                "assets/img/main/attention.png",
                                width: width * 0.02,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Liquids",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: showSecondMenu == "liquids"
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      changeTabMenu("liquids");
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: showSecondMenu == "liquids"
                        ? SlideTransition(
                            position: _slideAnimation,
                            child: MenuLiquids(
                              changeContent: widget.changeContent,
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(
                    width: width * 0.05,
                    child: Image.asset(
                      "assets/img/nav-icon/arrows.png",
                      width: width * 0.025,
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              "assets/img/nav-icon/solid-weights.png",
                              width: width * 0.04,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                "assets/img/main/attention.png",
                                width: width * 0.02,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Fixed weights",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: showSecondMenu == "fixed"
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      changeTabMenu("fixed");
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: showSecondMenu == "fixed"
                        ? SlideTransition(
                            position: _slideAnimation,
                            child: MenuFixed(
                              changeContent: widget.changeContent,
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(
                    width: width * 0.05,
                    child: Image.asset(
                      "assets/img/nav-icon/arrows.png",
                      width: width * 0.025,
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              "assets/img/nav-icon/calculation.png",
                              width: width * 0.04,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                "assets/img/main/attention.png",
                                width: width * 0.02,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Calculation",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: showSecondMenu == "calculate"
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      changeTabMenu("calculate");
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: showSecondMenu == "calculate"
                        ? SlideTransition(
                            position: _slideAnimation,
                            child: MenuCalculate(
                              changeContent: widget.changeContent,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              const Label()
            ],
          ),
        )
      ],
    );
  }
}
