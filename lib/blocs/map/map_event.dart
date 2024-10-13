part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller);
}

class OnStopFollowingUserEvent extends MapEvent {}
class OnStartFollowingUserEvent extends MapEvent {}

class UpdateUserPolylinesEvent extends MapEvent {
  final List<LatLng> locHistory;
  const UpdateUserPolylinesEvent({required this.locHistory});
}

class OnToggleUserRoute extends MapEvent {}

class OnNewPolylineEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const OnNewPolylineEvent(this.polylines, this.markers);
}