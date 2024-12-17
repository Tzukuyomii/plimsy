import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Label extends StatefulWidget {
  const Label({super.key});

  @override
  _LabelState createState() => _LabelState();
}

class _LabelState extends State<Label> {
  late String _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = _getCurrentTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancella il timer quando il widget viene smontato
    super.dispose();
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return DateFormat('dd/MM/yyyy hh:mm a').format(now);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
    });
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
              _currentTime,
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
