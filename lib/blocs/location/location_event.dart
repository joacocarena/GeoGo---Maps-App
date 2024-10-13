part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLoc;

  const OnNewUserLocationEvent(this.newLoc);
}

class OnFollowingUser extends LocationEvent {}

class OnStopFollowingUser extends LocationEvent {}