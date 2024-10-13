part of 'map_bloc.dart';

class MapState extends Equatable {
  
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showRoute;

  // PolyLines:
  final Map<String, Polyline> polyLines;
  final Map<String, Marker> markers; // to store the markers

  const MapState({
    this.isMapInitialized = false, 
    this.isFollowingUser = true,
    this.showRoute = true,
    final Map<String, Polyline>? polyLines,
    final Map<String, Marker>? markers
  }): polyLines = polyLines ?? const{},
      markers = markers ?? const{};
  
  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showRoute,
    Map<String, Polyline>? polyLines,
    Map<String, Marker>? markers
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    showRoute: showRoute ?? this.showRoute,
    polyLines: polyLines ?? this.polyLines,
    markers: markers ?? this.markers
  );
  
  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, showRoute, polyLines, markers];
}