import 'package:flutter/material.dart';
import 'package:plimsy/screens/safety.dart';
import 'package:plimsy/screens/signal.dart';
import 'package:plimsy/screens/stability.dart';

class OverallMenu extends StatefulWidget {
  const OverallMenu({super.key});
  @override
  State<OverallMenu> createState() {
    return _OverallMenu();
  }
}

class _OverallMenu extends State<OverallMenu> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;
      final width = constraints.maxWidth;

      void stabilityButton() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const Safety(),
          ),
        );
      }

      void safetyButton() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const Stability(),
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

      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: safetyButton,
              child: Stack(
                children: [
                  Image.asset('assets/img/main/security-icon.png'),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/img/main/no_validate.png",
                      width: 40,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: stabilityButton,
              child: Stack(
                children: [
                  Image.asset('assets/img/main/stability-icon.png'),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/img/main/validate.png",
                      width: 40,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: signalButton,
              child: Stack(
                children: [
                  Image.asset('assets/img/main/maps-icon.png'),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/img/main/attention.png",
                      width: 40,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
