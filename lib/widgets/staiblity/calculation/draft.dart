import 'package:flutter/material.dart';
import 'package:plimsy/widgets/3d_model/model3d_viewer.dart';

class Draft extends StatefulWidget {
  const Draft({super.key});

  @override
  State<Draft> createState() {
    return _Draft();
  }
}

class _Draft extends State<Draft> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Stack(
        children: [
          Center(
            child: Model3DViewer(),
          ),
          Text("DRAFT"),
        ],
      ),
    );
  }
}
