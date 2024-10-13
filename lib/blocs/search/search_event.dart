part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnManualMarkerActivatedEvent extends SearchEvent {}
class OnManualMarkerDesactivatedEvent extends SearchEvent {}

class OnPlacesFoundEvent extends SearchEvent {
  final List<Feature> places;
  const OnPlacesFoundEvent({required this.places});
}

class AddToHistoryEvent extends SearchEvent {
  final Feature place;
  const AddToHistoryEvent({required this.place});
}