part of 'search_bloc.dart';

class SearchState extends Equatable {

  final bool displayManualSettedMarker;
  final List<Feature> places; // prop to store the places found in the search
  final List<Feature> placesHistory; // history of places searched
  
  const SearchState({
    this.displayManualSettedMarker = false,
    this.places = const[],
    this.placesHistory = const[]
  });
  
  SearchState copyWith({
    bool? displayManualSettedMarker,
    List<Feature>? places,
    List<Feature>? placesHistory
  }) => SearchState(
    displayManualSettedMarker: displayManualSettedMarker ?? this.displayManualSettedMarker,
    places: places ?? this.places,
    placesHistory: placesHistory ?? this.placesHistory
  );

  @override
  List<Object> get props => [displayManualSettedMarker, places, placesHistory];
}