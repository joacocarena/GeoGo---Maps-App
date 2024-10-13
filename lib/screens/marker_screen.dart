import 'package:flutter/material.dart';
import 'package:maps_app/markers/markers.dart';

class MarkerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: EndMarkerPainter(km: 23, destination: 'laalalallala'),
          ),
        )
     ),
   );
  }
}