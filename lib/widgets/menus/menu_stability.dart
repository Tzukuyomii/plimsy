import 'package:flutter/material.dart';
import 'package:plimsy/widgets/menus/menu_calculate.dart';
import 'package:plimsy/widgets/menus/menu_liquids.dart';

class MenuStability extends StatefulWidget {
  const MenuStability({super.key});

  @override
  State<MenuStability> createState() {
    return _MenuStability();
  }
}

class _MenuStability extends State<MenuStability>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  String showSecondMenu = "";

  void changeTabMenu(index) {
    setState(() {
      if (index == 0) {
        showSecondMenu = "liquids";
      } else if (index == 1) {
        showSecondMenu = "fixed";
      } else if (index == 2) {
        showSecondMenu = "calculate";
      } else {
        showSecondMenu = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        AppBar(
          toolbarHeight: height * 0.10,
          backgroundColor: const Color.fromARGB(209, 55, 98, 114),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Stability Page",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      icon: Image.asset(
                        "assets/img/nav-icon/liquid-weights.png",
                        width: 50,
                      ),
                      child: Text(
                        "Liquids",
                        style: TextStyle(
                            color: showSecondMenu == "liquids"
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/img/nav-icon/solid-weights.png",
                        width: 50,
                      ),
                      child: Text(
                        "Fixed Weights",
                        style: TextStyle(
                            color: showSecondMenu == "fixed"
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/img/nav-icon/calculation.png",
                        width: 50,
                      ),
                      child: Text(
                        "Calculation",
                        style: TextStyle(
                            color: showSecondMenu == "calculate"
                                ? Colors.black
                                : Colors.white),
                      ),
                    )
                  ],
                  onTap: (index) {
                    changeTabMenu(index);
                  },
                ),
              ),
            ],
          ),
        ),
        if (showSecondMenu == "liquids") const MenuLiquids(),
        //if (showSecondMenu == "fixed") const MenuFixed(),
        if (showSecondMenu == "calculate") const MenuCalculate()
      ],
    );
  }
}
