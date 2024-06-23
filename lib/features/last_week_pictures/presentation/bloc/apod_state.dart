part of 'apod_bloc.dart';

sealed class ApodState extends Equatable {
  const ApodState();

  @override
  List<Object> get props => [];
}

final class ApodInitial extends ApodState {}

final class ApodLoading extends ApodState {}

final class ApodLoaded extends ApodState {
  final List<PictureOfTheDay> picturesList;

  const ApodLoaded({required this.picturesList});
}

final class ApodError extends ApodState {
  final String errorMessage;

  const ApodError({required this.errorMessage});
}

final class ApodNoConnectionError extends ApodState {
  const ApodNoConnectionError();
}
