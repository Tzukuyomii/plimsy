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
            builder: (ctx) => const Stability(),
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
        children: [
          InkWell(
            onTap: safetyButton,
            child: Stack(
              children: [
                Image.asset('assets/img/Safety.png'),
                const Positioned(
                  bottom: 30,
                  right: 10,
                  child: Icon(
                    Icons.cancel_sharp,
                    color: Colors.red,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: stabilityButton,
            child: Stack(
              children: [
                Image.asset('assets/img/Stability.png'),
                const Positioned(
                  bottom: 30,
                  right: 10,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: signalButton,
            child: Stack(
              children: [
                Image.asset('assets/img/Signal.png'),
                const Positioned(
                  bottom: 30,
                  right: 10,
                  child: Icon(
                    Icons.circle_notifications,
                    color: Colors.yellow,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
