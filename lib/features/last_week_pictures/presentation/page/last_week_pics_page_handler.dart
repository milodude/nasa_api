import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_api/core/widgets/generic_circular_progress_indicator.dart';
import 'package:nasa_api/features/last_week_pictures/presentation/page/pictures_list_page.dart';
import 'package:nasa_api/generated/l10n.dart';

import '../../../../core/widgets/generic_animated_title.dart';
import '../bloc/apod_bloc.dart';

/// LastWeekPicsPageHandler
///
/// Handler to call the event from APOD bloc to load all the pics.
class LastWeekPicsPageHandler extends StatefulWidget {
  const LastWeekPicsPageHandler({super.key});

  @override
  State<LastWeekPicsPageHandler> createState() =>
      _LastWeekPicsPageHandlerState();
}

class _LastWeekPicsPageHandlerState extends State<LastWeekPicsPageHandler> {
  @override
  void initState() {
    super.initState();
    //Need to call modular.
    Modular.get<ApodBloc>().add(GetLastWeekPicsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GenericAnimatedTitle(
          child: Text(AppLocalizations.of(context).nasaAppTitle),
        ),
      ),
      body: BlocBuilder<ApodBloc, ApodState>(
        builder: (BuildContext context, ApodState state) {
          if (state is ApodInitial || state is ApodLoading) {
            return const GenericCircularProgressindicator();
          } else if (state is ApodLoaded) {
            return PicturesListPage(
              pictures: state.picturesList,
            );
          } else if (state is ApodError) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text('Unhandled state'));
        },
      ),
    );
  }
}
