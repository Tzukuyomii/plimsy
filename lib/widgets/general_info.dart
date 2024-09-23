import 'package:flutter/material.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        height: height * 0.10,
        width: width * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(209, 55, 98, 114),
        ),
        child: const Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text('YACHT:'),
                  Text('MY U-FORCE'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text('DATE AND TIME'),
                  Text('AUGUST 13TH 2024 - 02:44 PM'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text('ZONE'),
                  Text('HAWAII (USA)'),
                ],
              ),
            ),
          ],
        ));
  }
}
