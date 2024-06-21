import 'package:equatable/equatable.dart';

class PictureOfTheDay extends Equatable {
  final DateTime date;
  final String copyright;
  final String explanation;
  final String title;
  final String url;

  const PictureOfTheDay(
      {required this.date,
      required this.copyright,
      required this.explanation,
      required this.title,
      required this.url});

  @override
  List<Object?> get props => [date, copyright, explanation, title, url];
}
