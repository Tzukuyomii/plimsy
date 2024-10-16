import 'package:flutter/material.dart';
import 'package:plimsy/data/general_info_data.dart';

// ignore: must_be_immutable
class GridInfo extends StatelessWidget {
  const GridInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Scrollbar(
        thumbVisibility: true,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Numero di colonne
            childAspectRatio: 2.4, // Mantieni un rapporto di aspetto quadrato
            mainAxisSpacing: 3,
            crossAxisSpacing: 0,
          ),
          itemCount: (cellData.length * 4), // Numero totale di celle (massimo)
          itemBuilder: (context, index) {
            final row = index ~/ 4; // Calcola la riga corrente
            final col = index % 4; // Calcola la colonna corrente

            // Verifica se la riga esiste e se contiene celle
            if (row < cellData.length) {
              if (col < cellData[row].length) {
                final cellText = cellData[row][col];

                // Definisci gli stili per le colonne
                TextStyle textStyle;
                if (col == 0 || col == 2) {
                  textStyle = const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16);
                } else {
                  textStyle = const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: 14);
                }

                return Container(
                  constraints: const BoxConstraints(
                    minWidth: 20, // Larghezza minima
                    maxWidth: 100, // Larghezza massima
                  ),
                  alignment: Alignment.centerLeft, // Centra il testo

                  child: Text(
                    cellText,
                    style: textStyle,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, // Limita il numero di righe
                  ),
                );
              }
            }

            // Se la cella non esiste, mostra una cella vuota
            return Container();
          },
        ),
      ),
    );
  }
}







//  // Stili personalizzati per colonne
//           TextStyle firstAndThirdColumnStyle = const TextStyle(
//               fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16);

//           TextStyle secondAndFourthColumnStyle = const TextStyle(
//               fontStyle: FontStyle.normal, color: Colors.white, fontSize: 14);
