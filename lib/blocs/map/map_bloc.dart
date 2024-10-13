import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/helpers/helpers.dart';

import 'package:maps_app/models/models.dart';
import '../blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<UpdateUserPolylinesEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>((event, emit) => emit(state.copyWith(showRoute: !state.showRoute)));

    on<OnNewPolylineEvent>((event, emit) => emit(state.copyWith(polyLines: event.polylines, markers: event.markers)));

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      
      if (locationState.lastKnownPosition != null) {
        add(UpdateUserPolylinesEvent(locHistory: locationState.locationHistory));
      }

      if ( !state.isFollowingUser ) return;
      if (locationState.lastKnownPosition == null) return;
      
      moveCamera(locationState.lastKnownPosition!);

    });
  
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    
    emit(state.copyWith(isFollowingUser: true));
    
    if (locationBloc.state.lastKnownPosition == null) return;
    moveCamera(locationBloc.state.lastKnownPosition!);
  }

  void _onPolylineNewPoint(UpdateUserPolylinesEvent event, Emitter<MapState> emit) {

    final myRoute = Polyline( // creating a polyline
      polylineId: const PolylineId('myRoute'),
      color: Colors.blue.shade700,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.locHistory
    );

    final currentPolylines = Map<String, Polyline>.from(state.polyLines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polyLines: currentPolylines));
  }


  Future createRoutePolyline(RouteLocation dest) async {

    final route = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 3,
      points: dest.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap
    );

    double kms = dest.distance / 1000;
    kms = (kms*100).floorToDouble();
    kms /= 100;

    double tripDuration = (dest.duration / 60).floorToDouble();



    // <-- CUSTOM MARKERS -->
    final customMarkerStart = await getStartCustomMarker(tripDuration.toInt(), 'My location');
    final customMarkerEnd = await getEndCustomMarker(kms.toInt(), dest.endDestination.properties.name);



    // start marker
    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      icon: customMarkerStart,
      position: dest.points.first,
    );

    // end marker
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      icon: customMarkerEnd,
      position: dest.points.last
    );

    final currentPolylines = Map<String, Polyline>.from(state.polyLines); // copy of the current polylines
    currentPolylines['route'] = route; // creating a new pair in the map, named "route" 

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(OnNewPolylineEvent(currentPolylines, currentMarkers));

    await Future.delayed(const Duration(milliseconds: 300));

  }


  void moveCamera(LatLng newLoc) {
    final cameraUpdate = CameraUpdate.newLatLng(newLoc);
    _mapController?.animateCamera(cameraUpdate);
    _mapController?.moveCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }

}