part of 'apod_bloc.dart';

sealed class ApodEvent extends Equatable {
  const ApodEvent();

  @override
  List<Object> get props => [];
}

/// GetLastWeekPicsEvent
///
/// Event that fets the lst week pictures of the day.
class GetLastWeekPicsEvent extends ApodEvent {
  final bool hasConnection;

  const GetLastWeekPicsEvent({required this.hasConnection});
}

/// SearchPicsEvent
///
/// Event that searches for week pictures of the day.
class SearchPicsEvent extends ApodEvent {
  final String searchInput;
  final bool hasConnection;

  const SearchPicsEvent({
    required this.searchInput,
    required this.hasConnection,
  });
}
