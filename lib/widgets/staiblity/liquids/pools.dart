import 'package:flutter/material.dart';

class Pools extends StatefulWidget {
  const Pools({super.key});

  @override
  State<Pools> createState() {
    return _Pools();
  }
}

class _Pools extends State<Pools> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text("POOLS"),
      ),
    );
  }
}
