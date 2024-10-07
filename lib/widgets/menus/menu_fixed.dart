import 'package:flutter/material.dart';

class MenuFixed extends StatelessWidget {
  const MenuFixed({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 40,
            ),
            InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/img/solid-weights/fixedweights.png",
                    width: 30,
                  ),
                  const Text(
                    "Fixed",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
