import 'package:flutter/material.dart';

class Stability extends StatefulWidget {
  const Stability({super.key});

  @override
  State<Stability> createState() {
    return _Stability();
  }
}

class _Stability extends State<Stability> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(209, 55, 98, 114),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Stability Page"),
            Expanded(
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    child: Text("Liquids"),
                    icon: Icon(Icons.water_drop_rounded),
                  ),
                  Tab(
                    child: Text("Fixed Weights"),
                    icon: Icon(Icons.gps_fixed),
                  ),
                  Tab(
                    child: Text("Calculation"),
                    icon: Icon(Icons.calculate_outlined),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
