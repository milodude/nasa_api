import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_api/features/last_week_pictures/presentation/bloc/apod_bloc.dart';
import 'package:nasa_api/generated/l10n.dart';

import '../../domain/entity/picture_of_the_day.dart';
import '../widgets/apod_card.dart';

/// PicturesListPage
///
/// Page that renders a list of pictures of the day.
class PicturesListPage extends StatefulWidget {
  const PicturesListPage({
    super.key,
    required this.pictures,
    required this.hasConnection,
    required this.inputText,
  });
  final List<PictureOfTheDay> pictures;
  final bool hasConnection;
  final String inputText;

  @override
  State<PicturesListPage> createState() => _PicturesListPageState();
}

class _PicturesListPageState extends State<PicturesListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onRefresh() {
    //Necesito la conexion y ver si tengo algo en el input?
    Modular.get<ApodBloc>().add(SearchPicsEvent(
        hasConnection: widget.hasConnection, searchInput: widget.inputText));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          _onRefresh();
        },
        child: widget.pictures.isEmpty
            ? Center(
                child: Text(AppLocalizations.of(context).noDataToShow),
              )
            : ListView.builder(
                itemCount: widget.pictures.length,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ApodCard(pictureOfTheDay: widget.pictures[index])
                      .animate(delay: Duration(milliseconds: 100 * index))
                      .slide(
                          begin: Offset.fromDirection(0, 1),
                          curve: Curves.easeIn);
                },
              ),
      ),
    );
  }
}
