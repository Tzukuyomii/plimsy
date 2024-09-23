import 'package:flutter/material.dart';
import 'package:plimsy/widgets/menus/container_menu.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ContainerMenu(
          isLogin: true,
        ),
      ),
    );
  }
}
