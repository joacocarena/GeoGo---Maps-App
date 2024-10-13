import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:maps_app/services/services.dart';
import '../../models/models.dart';
import '../../models/places_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  TrafficService trafficService;

  SearchBloc({
    required this.trafficService
  }) : super(const SearchState(displayManualSettedMarker: false)) {
    
    on<SearchEvent>((event, emit) {});

    on<OnManualMarkerActivatedEvent>((event, emit) => emit(state.copyWith(displayManualSettedMarker: true)));
    on<OnManualMarkerDesactivatedEvent>((event, emit) => emit(state.copyWith(displayManualSettedMarker: false)));
    on<OnPlacesFoundEvent>((event, emit) => emit(state.copyWith(places: event.places)));

    on<AddToHistoryEvent>((event, emit) => emit(state.copyWith(placesHistory: [event.place, ...state.placesHistory])));
  }

  Future<RouteLocation> getTripCoords(LatLng start, LatLng end) async {
    final trafficRes = await trafficService.getTripCoords(start, end);

    final destination = await trafficService.getPlaceInfoByCoords(end);

    final geometry = trafficRes.routes[0].geometry;
    // decoding geometry:
    final points = decodePolyline(geometry, accuracyExponent: 6); // accuracy: 6 (polyline6)
    final latLngList = points.map((e) => LatLng(e[0].toDouble(), e[1].toDouble())).toList();

    return RouteLocation(
      points: latLngList,
      duration: trafficRes.routes[0].duration,
      distance: trafficRes.routes[0].distance,
      endDestination: destination
    );
  }

  Future getPlacesByQuery(LatLng proximity, String query) async {

    final placesSearched = await trafficService.getResultsByQuery(proximity, query);

    add(OnPlacesFoundEvent(places: placesSearched));
  }

}