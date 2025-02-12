import 'package:flutter/material.dart';

class VesselStatus extends StatefulWidget {
  VesselStatus(
      {super.key,
      required this.stabilityScore,
      required this.criteriaIntact,
      required this.toReachMaxLoad,
      required this.firstDraft,
      required this.draftUpdated});

  bool draftUpdated;
  bool firstDraft;
  double toReachMaxLoad;
  final Map<String, dynamic>? criteriaIntact;
  int? stabilityScore;
  @override
  State<VesselStatus> createState() {
    return _VesselStatus();
  }
}

class _VesselStatus extends State<VesselStatus> {
  List<String> failedCriteria = [];

  /// **Estrae i criteri falliti**
  List<String> getFailedCriteria() {
    if (widget.criteriaIntact == null || widget.criteriaIntact!.isEmpty) {
      return [];
    }

    widget.criteriaIntact!.forEach((key, value) {
      if (value is Map<String, dynamic> &&
          value["result"] == "failed" &&
          value.containsKey("criterion")) {
        String criterion = value["criterion"].toString();
        if (criterion.isNotEmpty) {
          failedCriteria.add(criterion[0]); // Prende il primo carattere
        }
      }
    });

    return failedCriteria;
  }

  String getStatusImage() {
    if (!widget.firstDraft) {
      return "assets/img/calculations-main/icon-status-waiting.png";
    }
    if (failedCriteria.isNotEmpty || widget.toReachMaxLoad < 0) {
      return "assets/img/calculations-main/icon-status-warning.png";
    }
    if (!widget.draftUpdated) {
      return "assets/img/calculations-main/icon-status-waiting.png";
    } else {
      return "assets/img/calculations-main/icon-status-ready.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: CustomPaint(
                size: Size(width * 0.09,
                    height * 0.07), // Dimensioni della barra semicircolare
                painter: SemicircleBorderPainter(
                    stabilityScore: widget.stabilityScore ?? 0),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: widget.stabilityScore != null && failedCriteria.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${widget.stabilityScore}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      width * 0.015, // Font size più grande
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "/100",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      width * 0.01, // Font size più piccolo
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Stability Score",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : Image.asset(
                      getStatusImage(),
                    ),
            ),
          ],
        ),
        if (!widget.firstDraft ||
            (!widget.draftUpdated && widget.toReachMaxLoad >= 0))
          Text(
            "- Please asses the draft of the vessel",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.01,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (widget.toReachMaxLoad < 0 && widget.firstDraft)
          Text(
            "- The vessel reached the maximum allowable displacement, please disembark: ${widget.toReachMaxLoad} t",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.01,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (failedCriteria.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: failedCriteria.map((criterionNumber) {
                  return Text(
                    "⚠ Vessel not complying with stability criterion n. $criterionNumber",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        if ((widget.draftUpdated &&
                widget.firstDraft &&
                failedCriteria.isEmpty &&
                widget.stabilityScore != null) ||
            (widget.firstDraft &&
                widget.toReachMaxLoad >= 0 &&
                failedCriteria.isEmpty &&
                widget.draftUpdated))
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "- No issues found.",
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.01,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

class SemicircleBorderPainter extends CustomPainter {
  final int stabilityScore;

  SemicircleBorderPainter({required this.stabilityScore});
  Color getColor() {
    if (stabilityScore < 30) {
      return Colors.red;
    } else if (stabilityScore < 70) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    final filledPaint = Paint()
      ..color = getColor()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    canvas.drawArc(rect, 3.14, 3.14, false, paint);

    double sweepAngle = (3.14 * stabilityScore) / 100;
    canvas.drawArc(rect, 3.14, sweepAngle, false, filledPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
