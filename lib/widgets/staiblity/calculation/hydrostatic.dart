import 'package:flutter/material.dart';

class Hydrostatic extends StatefulWidget {
  const Hydrostatic({super.key});
  @override
  State<Hydrostatic> createState() {
    return _Hydrostatic();
  }
}

class _Hydrostatic extends State<Hydrostatic> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Demo Version...",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
