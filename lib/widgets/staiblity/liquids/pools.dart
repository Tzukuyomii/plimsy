import 'package:flutter/material.dart';
import 'package:plimsy/data/note_pools.dart';
import 'package:plimsy/models/tank.dart';
import 'package:plimsy/widgets/3d_model/model3d_viewer.dart';
import 'package:plimsy/widgets/staiblity/liquids/dynamic_radio_button.dart';
import 'package:plimsy/widgets/staiblity/liquids/liquids_on_board_container.dart';
import 'package:plimsy/widgets/staiblity/liquids/slider_tank.dart';

class Pools extends StatefulWidget {
  Pools({
    super.key,
    required this.selectColor,
    required this.tanks,
    required this.updateTanks,
    required this.percentageNotifier,
  });

  Function selectColor;
  Function updateTanks;
  Map<String, List<Tank>> tanks;
  final Map<String, ValueNotifier<double>> percentageNotifier;

  @override
  State<Pools> createState() {
    return _Pools();
  }
}

class _Pools extends State<Pools> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Stack(
        children: [
          const Center(
            child: Model3DViewer(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: LiquidsOnBoardContainer(
                  percentageNotifier: widget.percentageNotifier,
                  tanksData: widget.tanks,
                  selectColor: widget.selectColor,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: SliderTank(
                          updateTanks: widget.updateTanks,
                          tanksData: widget.tanks,
                          selectedTank: "POOLS",
                          selectColor: widget.selectColor,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: DynamicRadioButtons(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                  width: width * 0.3,
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: Column(
                      children: [
                        Text(warningPools,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.01,
                            ),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          notePools,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.01,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
