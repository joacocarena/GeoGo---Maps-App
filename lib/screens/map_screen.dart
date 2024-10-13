import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/widgets/widgets.dart';

import '../views/views.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          
          if (locationState.lastKnownPosition == null) return const Center(child: Text('Please wait...'));
          
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {

              Map<String, Polyline> polylines = Map.from(mapState.polyLines);
              if (!mapState.showRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute'); // delete only the polyline with key "myRoute" (must see map_bloc.dart)
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownPosition!,
                      polyLines: polylines.values.toSet(),
                      markers: mapState.markers.values.toSet(), // adding the markers
                    ),

                    const SearchbarCustom(),
                    const SettedMarker()
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}