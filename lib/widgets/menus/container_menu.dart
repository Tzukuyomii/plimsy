import 'package:flutter/material.dart';
import 'package:plimsy/widgets/general_info/general_info.dart';
import 'package:plimsy/widgets/menus/overall_menu.dart';

// ignore: must_be_immutable
class ContainerMenu extends StatefulWidget {
  ContainerMenu(
      {super.key,
      required this.containerWidth,
      required this.containerHeight,
      required this.isOpen,
      required this.fadeAnimation,
      required this.showContent,
      required this.onDialogOpenChange,
      required this.apiKey,
      required this.data});

  Map<String, dynamic> data;

  late Animation<double> fadeAnimation;
  final Function onDialogOpenChange;

  String apiKey;
  double containerWidth;
  double containerHeight;
  bool isOpen;
  bool showContent;
  @override
  State<ContainerMenu> createState() {
    return _ContainerMenu();
  }
}

class _ContainerMenu extends State<ContainerMenu> {
  final TextEditingController _controller = TextEditingController();
  String _selectedOption = "Auto";

  void _onRadioButtonChanged(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.text = "1.025"; // Valore iniziale del TextField
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      height: widget.containerHeight,
      width: widget.containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(1, 86, 118, 0.8),
      ),
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: widget.showContent
            ? GeneralInfo(
                apiKey: widget.apiKey,
                changeSize: widget.onDialogOpenChange,
                data: widget.data,
                controller: _controller,
                onRadioButtonChanged: _onRadioButtonChanged,
                selectedOption: _selectedOption,
              )
            : OverallMenu(
                data: widget.data,
                apiKey: widget.apiKey,
                forceHeeling: _selectedOption,
                seaWaterDensity: _controller.text,
              ),
      ),
    );
  }
}
