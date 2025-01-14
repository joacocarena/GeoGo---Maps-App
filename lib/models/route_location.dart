import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/places_model.dart';

class RouteLocation {
  final List<LatLng> points;
  final double duration;
  final double distance;
  final Feature endDestination;

  RouteLocation({required this.points, required this.duration, required this.distance, required this.endDestination});
}