import 'package:flutter/material.dart';
import 'package:plimsy/widgets/modale/grid_info.dart';

class ModaleInfo extends StatelessWidget {
  const ModaleInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: const Color.fromRGBO(1, 86, 118, 0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Arrotonda gli angoli
      ),
      child: Container(
        width: width * 0.7, // Larghezza personalizzata
        height: height * 0.7, // Altezza personalizzata
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/img/logos/white-logo.png",
                  width: 400,
                ),
                // GridInfo(),
                Image.asset(
                  "assets/img/info-panel/go-back-icon.png",
                  width: 100,
                )
              ],
            ),
            Column(
              children: [
                const Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "General Settings",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [],
                        ),
                        Row(
                          children: [],
                        ),
                        Row(
                          children: [],
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset("assets/img/info-panel/contact-us-icon.png"),
                    Image.asset("assets/img/info-panel/help-icon.png"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
