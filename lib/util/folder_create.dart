import 'dart:convert'; // Per JSON e Base64
import 'dart:io'; // Per i file
import 'package:path_provider/path_provider.dart'; // Per le directory

Future<void> processAssets(String response) async {
  // Decodifica la risposta principale
  List<dynamic> jsonResponse = jsonDecode(response);

  // Ottieni la directory per salvare i file
  final directory = await getApplicationDocumentsDirectory();
  String customFolderName = "services_folder";
  String folderPath = "${directory.path}/$customFolderName";
  final folder = Directory(folderPath);

  for (var asset in jsonResponse) {
    // Leggi i dettagli di ogni file
    String fileName = "${asset['name']}${asset['ext']}";
    String fileEncoded = asset['fileEncoded'];
    List<int> fileBytes = base64Decode(fileEncoded);

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
  listSavedFiles();
}

Future<void> listSavedFiles() async {
  final directory = await getApplicationDocumentsDirectory();
  String folderPath = "${directory.path}/services_folder";
  final folder = Directory(folderPath);

  if (folder.existsSync()) {
    List<FileSystemEntity> files = folder.listSync();
    for (var file in files) {
      print("File trovato: ${file.path}");
    }
  } else {
    print("La directory non esiste ancora.");
  }
}
