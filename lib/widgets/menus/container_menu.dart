import 'package:flutter/material.dart';
import 'package:plimsy/widgets/login.dart';
import 'package:plimsy/widgets/menus/overall_menu.dart';

class ContainerMenu extends StatefulWidget {
  const ContainerMenu({super.key, required this.isLogin});

  final bool isLogin;

  @override
  State<ContainerMenu> createState() {
    return _ContainerMenu();
  }
}

class _ContainerMenu extends State<ContainerMenu> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      height: height * 0.20,
      width: width * 0.60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(1, 86, 118, 0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/logos/white-logo.png',
            width: width * 0.25,
          ),
          SizedBox(
            width: width * 0.05,
          ),
          Expanded(
            child: widget.isLogin ? const Login() : const OverallMenu(),
          )
        ],
      ),
    );
  }
}
