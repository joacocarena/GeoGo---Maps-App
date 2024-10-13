import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';
import 'package:maps_app/models/places_model.dart';
import 'package:maps_app/services/services.dart';

class TrafficService {

  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _trafficBaseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _placesUrl = 'https://api.mapbox.com/search/geocode/v6';
  final String? tripMode;

  TrafficService({this.tripMode = 'driving'})
    : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
      _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getTripCoords(LatLng start, LatLng end) async {
    
    final coordsInString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_trafficBaseUrl/$tripMode/$coordsInString';
    
    final res = await _dioTraffic.get(url);
    final data = TrafficResponse.fromJson(res.data);
    
    return data;
  }

  // see the places_models.dart to use this function:
  Future<List<Feature>> getResultsByQuery(LatLng proximity, String query) async {

    if (query.isEmpty) return [];

    final resp = await _dioPlaces.get('$_placesUrl/forward', queryParameters: {
      'q': query,
      'proximity': '${proximity.longitude},${proximity.latitude}',
      'limit': 5
    });

    final placesResponse = PlacesResponse.fromJson(resp.data);

    return placesResponse.features;

  }

  Future<Feature> getPlaceInfoByCoords(LatLng coords) async {

    _dioPlaces.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    final resp = await _dioPlaces.get('$_placesUrl/reverse', queryParameters: {
      'longitude': coords.longitude,
      'latitude': coords.latitude
    });

    final placesResponse = PlacesResponse.fromJson(resp.data);

    return placesResponse.features[0];
  }

}