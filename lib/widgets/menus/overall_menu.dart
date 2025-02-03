import 'package:flutter/material.dart';
import 'package:plimsy/screens/safety.dart';
import 'package:plimsy/screens/signal.dart';
import 'package:plimsy/screens/stability.dart';

class OverallMenu extends StatefulWidget {
  OverallMenu(
      {super.key,
      required this.data,
      required this.apiKey,
      required this.forceHeeling,
      required this.seaWaterDensity});

  String apiKey;
  Map<String, dynamic> data;
  String forceHeeling;
  String seaWaterDensity;

  @override
  State<OverallMenu> createState() {
    return _OverallMenu();
  }
}

class _OverallMenu extends State<OverallMenu> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        void stabilityButton() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => Stability(
                data: widget.data,
                apiKey: widget.apiKey,
                forceHeeling: widget.forceHeeling,
                seaWaterDensity: widget.seaWaterDensity,
              ),
            ),
          );
        }

        void safetyButton() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const Safety(),
            ),
          );
        }

        void signalButton() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const Signal(),
            ),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/img/logos/main-logo.png',
              width: width * 0.4,
            ),
            SizedBox(
              width: width * 0.05,
            ),
            InkWell(
              onTap: safetyButton,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/img/main/security-icon.png',
                    width: width * 0.15,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/img/main/no_validate.png",
                      width: width * 0.07,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: stabilityButton,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/img/main/stability-icon.png',
                    width: width * 0.15,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/img/main/validate.png",
                      width: width * 0.07,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: signalButton,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/img/main/maps-icon.png',
                    width: width * 0.15,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/img/main/attention.png",
                      width: width * 0.07,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
