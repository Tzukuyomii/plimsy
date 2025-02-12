import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:path_provider/path_provider.dart';

class Model3DViewer extends StatefulWidget {
  const Model3DViewer({super.key});

  @override
  _Model3DViewerState createState() => _Model3DViewerState();
}

class _Model3DViewerState extends State<Model3DViewer> {
  Flutter3DController controller = Flutter3DController();
  String modelPath = "";

  // Funzione per ottenere il percorso corretto del file
  Future<void> _getModelPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = "file://${directory.path}/services_folder/intact-model.gltf";

    // Controlla se il file esiste, altrimenti carica il modello 3D
    setState(() {
      modelPath = path; // Aggiorna il percorso per caricare il modello
    });
  }

  @override
  void initState() {
    super.initState();
    _getModelPath();
    controller = Flutter3DController();
  }

  @override
  Widget build(BuildContext context) {
    // Attendi che il percorso sia stato caricato prima di costruire il 3D viewer
    if (modelPath.isEmpty) {
      return const Center(
          child: CircularProgressIndicator()); // Mostra il loading
    }

    return Flutter3DViewer(
      controller: controller,
      src: modelPath, // Usa il percorso corretto per il file .gltf
    );
  }
}
