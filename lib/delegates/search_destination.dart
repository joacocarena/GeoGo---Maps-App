import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestination extends SearchDelegate<SearchResult> { // always return a SearchResult type

  SearchDestination(): super(
    searchFieldLabel: 'Search here...'
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, SearchResult(cancel: true, manuallySearch: false)), 
      icon: const Icon(Icons.arrow_back_ios)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnownPosition!;

    searchBloc.getPlacesByQuery(proximity, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {

        final places = state.places;
        
        if (places.isEmpty) {
          return const Center(
            child: Text('No places found!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          );
        }

        return ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(places[index].properties.name),
            subtitle: Text(places[index].properties.placeFormatted),
            leading: places[index].properties.featureType == 'place' ? const Icon(Icons.place, size: 24) : const Icon(Icons.directions),
            onTap: () {
              
              final res = SearchResult(
                cancel: false, 
                manuallySearch: false,
                coords: LatLng(places[index].geometry.coordinates[1], places[index].geometry.coordinates[0]),
                name: places[index].properties.name,
                description: places[index].properties.placeFormatted
              );

              searchBloc.add(AddToHistoryEvent(place: places[index]));

              close(context, res);

            },
          ), 
          separatorBuilder: (context, index) => const Divider(), 
          itemCount: places.length
        );

      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final placesHistory = BlocProvider.of<SearchBloc>(context).state.placesHistory;

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          title: const Text('Set the location manually', style: TextStyle(color: Colors.black)),
          onTap: () {
            close(context, SearchResult(cancel: false, manuallySearch: true));
          },
        ),

        ...placesHistory.map((e) => ListTile(
          title: Text(e.properties.name),
          subtitle: Text(e.properties.placeFormatted),
          leading: e.properties.featureType == 'place' ? const Icon(Icons.place, size: 24) : const Icon(Icons.directions),
        ))
      ],
    );
  }

}