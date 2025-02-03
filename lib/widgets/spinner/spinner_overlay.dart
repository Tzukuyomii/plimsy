import 'package:flutter/material.dart';
import 'package:plimsy/widgets/spinner/spinner_provider.dart';
import 'package:provider/provider.dart';

class SpinnerOverlay extends StatelessWidget {
  final gifPath = "assets/img/boat-loader/boat-loader-unscreen.gif";

  const SpinnerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<SpinnerProvider>().isLoading;

    if (!isLoading) return const SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        color: Colors.blue
            .withOpacity(0.3), // Colore di sfondo trasparente azzurrino
        child: Center(
          child: Image.asset(
            gifPath, // Carica la GIF da un asset
            width: 100, // Imposta le dimensioni della GIF
            height: 100, // Imposta le dimensioni della GIF
            fit: BoxFit.contain, // Mantieni la GIF proporzionata
          ),
        ),
      ),
    );
  }
}
