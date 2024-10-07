import 'package:flutter/material.dart';

class MenuCalculate extends StatelessWidget {
  const MenuCalculate({super.key});

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
                    "assets/img/calculations-main/loadline-status.png",
                    width: 40,
                  ),
                  const Text(
                    "Draft",
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
