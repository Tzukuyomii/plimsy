import 'package:flutter/material.dart';
import 'package:plimsy/data/general_info_data.dart';

// ignore: must_be_immutable
class GridInfo extends StatelessWidget {
  const GridInfo(
      {super.key,
      required this.generalInformation,
      required this.vesselHydrostaticData});

  final Map<String, dynamic> generalInformation;
  final Map<String, dynamic> vesselHydrostaticData;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Scrollbar(
        thumbVisibility: true,
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...generalInformation.entries.map((entry) => ListTile(
                          title: Text(
                            entry.key,
                            style: TextStyle(
                                fontSize: width * 0.012,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            entry.value,
                            style: TextStyle(
                                fontSize: width * 0.01, color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...vesselHydrostaticData.entries.map((entry) => ListTile(
                          title: Text(
                            entry.key,
                            style: TextStyle(
                                fontSize: width * 0.012,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            entry.value,
                            style: TextStyle(
                                fontSize: width * 0.01, color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
