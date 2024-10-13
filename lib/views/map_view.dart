import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/themes.dart';

import '../blocs/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final Set<Polyline> polyLines; // requesting polylines
  final Set<Marker> markers;

  const MapView({super.key, required this.initialLocation, required this.polyLines, required this.markers});

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation, // target to show in the map
      zoom: 15
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener( // new widget to avoid multiple state changes
        onPointerMove: (pointerEvent) => mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true, // show the blue dot (my position)
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          indoorViewEnabled: true,
          polylines: polyLines,
          style: jsonEncode(lightTheme),
          onMapCreated: (controller) => mapBloc.add(OnMapInitializedEvent(controller)),
          markers: markers, // adding markers to the map
          onCameraMove: (position) => mapBloc.mapCenter = position.target, // obtaining the center of the map
        ),
      ),
    );
  }
}