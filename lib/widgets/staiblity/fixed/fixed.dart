import 'package:flutter/material.dart';

class Fixed extends StatefulWidget {
  const Fixed({super.key});

  @override
  State<Fixed> createState() {
    return _Fixed();
  }
}

class _Fixed extends State<Fixed> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text("FIXED"),
      ),
    );
  }
}
