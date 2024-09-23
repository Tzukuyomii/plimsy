import 'package:flutter/material.dart';
import 'package:plimsy/widgets/menus/container_menu.dart';
import 'package:plimsy/widgets/general_info.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContainerMenu(
                    isLogin: false,
                  ),
                ],
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GeneralInfo(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
