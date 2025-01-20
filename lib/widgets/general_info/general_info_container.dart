import 'package:flutter/material.dart';
import 'package:plimsy/widgets/general_info/label.dart';

class GeneralInfoContainer extends StatefulWidget {
  final Function onDialogOpenChange;
  GeneralInfoContainer(
      {super.key,
      required this.onDialogOpenChange,
      required this.shipName,
      required this.zone});

  String shipName;
  String zone;

  @override
  State<GeneralInfoContainer> createState() {
    return _GeneralInfoContainer();
  }
}

class _GeneralInfoContainer extends State<GeneralInfoContainer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      height: height * 0.12,
      width: width * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(1, 86, 118, 0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Label(
              shipName: widget.shipName,
              zone: widget.zone,
            ),
          ),
          InkWell(
            onTap: () {
              widget.onDialogOpenChange();
            },
            child: Image.asset(
              "assets/img/main/info-icon.png",
              width: width * 0.05,
            ),
          )
        ],
      ),
    );
  }
}
