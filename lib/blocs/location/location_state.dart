part of 'location_bloc.dart';

class LocationState extends Equatable {
  
  final bool followingUser;
  final LatLng? lastKnownPosition;
  final List<LatLng> locationHistory;
  
  const LocationState({
    this.followingUser = false,
    this.lastKnownPosition,
    locationHistory
  }): locationHistory = locationHistory ?? const[]; // el locationHistory va a ser igual al locationHistory que se le pasa y si no se le pasa es vacio
  
  LocationState copyWith({
    bool? followingUser,
    final LatLng? lastKnownPosition,
    final List<LatLng>? locationHistory
  }) => LocationState(
    followingUser: followingUser ?? this.followingUser,
    lastKnownPosition: lastKnownPosition ?? this.lastKnownPosition,
    locationHistory: locationHistory ?? this.locationHistory
  );

  @override
  List<Object?> get props => [followingUser, lastKnownPosition, locationHistory];
}