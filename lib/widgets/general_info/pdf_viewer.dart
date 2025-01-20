import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerDialog extends StatelessWidget {
  PdfViewerDialog({super.key});
  String pdfFileName =
      "User-guide.pdf"; // Nome del file PDF da leggere (es. User-guide.pdf)

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return FutureBuilder<String>(
      future: _getPdfPath(pdfFileName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AlertDialog(
            title: Text("Caricamento PDF"),
            content: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: const Text("Errore"),
            content: Center(child: Text("Errore: ${snapshot.error}")),
          );
        } else if (snapshot.hasData) {
          return AlertDialog(
            content: SizedBox(
              width: width,
              height:
                  height, // Imposta l'altezza del PDF in base alle tue necessità
              child: PDFView(
                filePath: snapshot.data!,
                autoSpacing: true,
                enableSwipe: true,
                swipeHorizontal: true,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Chiude il dialog
                },
                child: const Text("Chiudi"),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: const Text("File non trovato"),
            content:
                const Center(child: Text("Il file PDF non è stato trovato.")),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Chiude il dialog
                },
                child: const Text("Chiudi"),
              ),
            ],
          );
        }
      },
    );
  }

  // Funzione per ottenere il percorso completo del file PDF salvato
  Future<String> _getPdfPath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/services_folder/$fileName";
  }
}
