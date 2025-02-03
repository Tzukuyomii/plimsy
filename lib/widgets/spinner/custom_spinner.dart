import 'package:flutter/material.dart';

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({super.key});

  final gifPath = "assets/img/boat-loader/boat-loader-unscreen.gif";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        // Se vuoi intercettare il tocco e impedire l'interazione durante il caricamento
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Expanded(
        child: Container(
          color: Colors.blue.withOpacity(0.3), // Colore di sfondo azzurrino
          width: width,
          height: height,
          child: Center(
            child: Image.asset(
              gifPath, // Carica la GIF da un asset
              width: 100, // Imposta le dimensioni della GIF
              height: 100, // Imposta le dimensioni della GIF
              fit: BoxFit.contain, // Mantieni la GIF proporzionata
            ),
          ),
        ),
      ),
    );
  }
}
