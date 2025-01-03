import 'dart:convert'; // Per JSON e Base64
import 'dart:io'; // Per i file
import 'package:path_provider/path_provider.dart'; // Per le directory

Future<void> processAssets(String response) async {
  // Decodifica la risposta principale
  Map<String, dynamic> jsonResponse = jsonDecode(response);

  // Estrai `assets` e decodifica la stringa JSON contenuta
  String assetsString = jsonResponse['res']['assets'];
  List<dynamic> assets = jsonDecode(assetsString);

  // Ottieni la directory per salvare i file
  final directory = await getApplicationDocumentsDirectory();

  for (var asset in assets) {
    // Leggi i dettagli di ogni file
    String fileName = "${asset['name']}${asset['ext']}";
    String fileEncoded = asset['fileEncoded'];
    List<int> fileBytes = base64Decode(fileEncoded);

    // Percorso della cartella
    String customFolderName = "services_folder";
    String folderPath = "${directory.path}/assets/$customFolderName";
    final folder = Directory(folderPath);

    // Crea la cartella se non esiste
    if (!folder.existsSync()) {
      await folder.create(recursive: true);
    }

    // Scrivi il file nella cartella
    String filePath = "$folderPath/$fileName";
    final file = File(filePath);
    await file.writeAsBytes(fileBytes);

    print("File creato: $filePath");
  }
}
