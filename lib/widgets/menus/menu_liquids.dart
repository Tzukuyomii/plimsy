import 'package:flutter/material.dart';

class MenuLiquids extends StatelessWidget {
  const MenuLiquids({super.key});

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
                  "assets/img/tanks-page/tanks-icon.png",
                  width: 30,
                ),
                const Text(
                  "Tanks",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )),
            const SizedBox(
              width: 30,
            ),
            InkWell(
                child: Column(
              children: [
                Image.asset(
                  "assets/img/tanks-page/pools-icon.png",
                  width: 30,
                ),
                const Text(
                  "Pools",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ))
          ],
        ),
      );
    });
  }
}
