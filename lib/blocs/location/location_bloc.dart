import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription? positionStream; // this will store the subscription to be closed (getPositionStream)

  LocationBloc() : super(const LocationState()) {

    on<OnFollowingUser>((event, emit) => emit(state.copyWith(followingUser: true)));
    on<OnStopFollowingUser>((event, emit) => emit(state.copyWith(followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) => emit(state.copyWith(
      lastKnownPosition: event.newLoc,
      locationHistory: [...state.locationHistory, event.newLoc]
    )));
  }

  // method to obtain the actual position of the user
  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  // method to listen the location changes of the user
  void startFollowingUser() async {
    positionStream = Geolocator.getPositionStream().listen((event) { // This method will be listening for any changes that occur. "event" has a "Position" type
      
      final position = event;

      add(OnFollowingUser());
      
      add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingUser()); // agrego el evento
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
