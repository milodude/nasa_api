part of 'apod_bloc.dart';

sealed class ApodEvent extends Equatable {
  const ApodEvent();

  @override
  List<Object> get props => [];
}

/// GetLastWeekPicsEvent
///
/// Event that fets the lst week pictures of the day.
class GetLastWeekPicsEvent extends ApodEvent {}
