import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Model3DViewer extends StatefulWidget {
  const Model3DViewer({super.key});

  @override
  _Model3DViewerState createState() => _Model3DViewerState();
}

class _Model3DViewerState extends State<Model3DViewer> {
  Flutter3DController controller = Flutter3DController();
  final String modelPath =
      "file:///data/user/0/com.example.plimsy/app_flutter/services_folder/intact-model.gltf";

  @override
  void initState() {
    super.initState();
    controller = Flutter3DController();
  }

  @override
  Widget build(BuildContext context) {
    return Flutter3DViewer(
      controller: controller,
      src: modelPath,
    );
  }
}
