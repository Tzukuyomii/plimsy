import 'package:flutter/material.dart';

class MenuSignal extends StatefulWidget {
  const MenuSignal({super.key});

  @override
  State<MenuSignal> createState() {
    return _MenuSignal();
  }
}

class _MenuSignal extends State<MenuSignal> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: const Color.fromARGB(209, 55, 98, 114),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Stability Page dropdown",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      icon: Image.asset(
                        "assets/img/liquids.png",
                        width: 35,
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (String value) {
                          // Azioni da eseguire quando un'opzione è selezionata
                          print("Selezionato: $value");
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Tanks',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.propane_tank_rounded,
                                  color: Colors.black,
                                ),
                                Text("Tanks")
                              ],
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Pools',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.pool,
                                  color: Colors.black,
                                ),
                                Text("Pools")
                              ],
                            ),
                          ),
                        ],
                        child: const Text(
                          'Liquids',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/img/fixed.png",
                        width: 35,
                      ),
                      child: const Text(
                        "Fixed Weights",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/img/calculate.png",
                        width: 35,
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (String value) {
                          // Azioni da eseguire quando un'opzione è selezionata
                          print("Selezionato: $value");
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Tanks',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.file_upload_outlined,
                                  color: Colors.black,
                                ),
                                Text("Draft")
                              ],
                            ),
                          ),
                        ],
                        child: const Text(
                          'Calculation',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
