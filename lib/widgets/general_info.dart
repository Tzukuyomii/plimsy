import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plimsy/widgets/modale/modale_info.dart';

class GeneralInfo extends StatefulWidget {
  final Function(bool) onDialogOpenChange;
  const GeneralInfo({super.key, required this.onDialogOpenChange});

  @override
  State<StatefulWidget> createState() {
    return _GeneralInfo();
  }
}

class _GeneralInfo extends State<GeneralInfo> {
  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('dd/MM/yyyy hh:mm a').format(now);

    return formattedTime;
  }

  Future<void> _showCenterModal(BuildContext context) async {
    widget.onDialogOpenChange(false);

    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return const ModaleInfo();
      },
    );

    widget.onDialogOpenChange(true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        _showCenterModal(context);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          height: height * 0.10,
          width: width * 0.40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(1, 86, 118, 0.8),
          ),
          child: Column(
            children: [
              const Expanded(
                child: Row(
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
              ),
              Expanded(
                child: Row(
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
              ),
              const Expanded(
                child: Row(
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
              ),
            ],
          )),
    );
  }
}
