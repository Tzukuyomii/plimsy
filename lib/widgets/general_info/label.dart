import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Label extends StatefulWidget {
  Label({super.key, required this.shipName, required this.zone});

  String shipName;
  String zone;

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'YACHT:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              width: width * 0.015,
            ),
            Text(
              'MY ${widget.shipName}',
              style: const TextStyle(
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
            SizedBox(
              width: width * 0.015,
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
        Row(
          children: [
            const Text(
              'ZONE:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              width: width * 0.015,
            ),
            Text(
              widget.zone,
              style: const TextStyle(
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
