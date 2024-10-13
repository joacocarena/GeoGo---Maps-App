import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/models/models.dart';
import '../blocs/blocs.dart';
import '../delegates/delegates.dart';

class SearchbarCustom extends StatelessWidget {
  const SearchbarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualSettedMarker
          ? const SizedBox()
          : const _SearchbarCustomBody();
      },
    );
  }
}

class _SearchbarCustomBody extends StatelessWidget {
  const _SearchbarCustomBody();


  void onSearchResult(BuildContext context, SearchResult res) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context); // Instance of MapBloc
    final locationBloc = BlocProvider.of<LocationBloc>(context); // Instance of LocationBloc

    if (res.manuallySearch) {
      searchBloc.add(OnManualMarkerActivatedEvent());
      return;
    }

    if (res.coords == null) return;
    final finalLocation = await searchBloc.getTripCoords(locationBloc.state.lastKnownPosition!, LatLng(res.coords!.latitude, res.coords!.longitude));
    await mapBloc.createRoutePolyline(finalLocation);
  }


  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 300),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              final res = await showSearch(
                context: context,
                delegate: SearchDestination()
              );
              if (res == null) return;
              
              // ignore: use_build_context_synchronously
              onSearchResult(context ,res);
            }, 
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0,5)
                  )
                ]
              ),
              child: const Text('Where do you want to go?', style: TextStyle(color: Colors.black87)),
            ),
          ),
        ),
      ),
    );
  }
}