import 'package:flutter/material.dart';

class VesselStatus extends StatefulWidget {
  const VesselStatus({super.key});
  @override
  State<VesselStatus> createState() {
    return _VesselStatus();
  }
}

class _VesselStatus extends State<VesselStatus> {
  @override
  Widget build(BuildContext context) {
    return const Text("Vessel Status");
  }
}
