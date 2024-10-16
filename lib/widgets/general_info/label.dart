import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Label extends StatelessWidget {
  const Label({super.key});

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('dd/MM/yyyy hh:mm a').format(now);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'YACHT:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'MY U-FORCE',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'DATE AND TIME:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              getCurrentTime(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        const Row(
          children: [
            Text(
              'ZONE:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'HAWAII (USA)',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
