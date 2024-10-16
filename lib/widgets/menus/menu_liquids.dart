import 'package:flutter/material.dart';

class MenuLiquids extends StatelessWidget {
  MenuLiquids({super.key, required this.changeContent});

  Function changeContent;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.02,
          ),
          InkWell(
            onTap: () {
              changeContent("Tanks");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/img/tanks-page/tanks-icon.png",
                  width: width * 0.025,
                ),
                const Text(
                  "Tanks",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.01,
          ),
          InkWell(
            onTap: () {
              changeContent("Pools");
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/img/tanks-page/pools-icon.png",
                  width: width * 0.025,
                ),
                const Text(
                  "Pools",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
