import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancel;
  final bool manuallySearch;
  final LatLng? coords;
  final String? name;
  final String? description;

  SearchResult({
    required this.cancel, 
    required this.manuallySearch,
    this.coords,
    this.name,
    this.description
  });

  @override
  String toString() {
    return '{cancel: $cancel, manual: $manuallySearch}';
  }
}