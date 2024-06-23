import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nasa_api/core/providers/debug_provider.dart';
import 'package:nasa_api/core/widgets/generic_input.dart';
import 'package:nasa_api/generated/l10n.dart';

import '../../domain/entity/picture_of_the_day.dart';
import '../widgets/apod_card.dart';

/// PicturesListPage
///
/// Page that renders a list of pictures of the day.
class PicturesListPage extends StatefulWidget {
  const PicturesListPage({super.key, required this.pictures});
  final List<PictureOfTheDay> pictures;

  @override
  State<PicturesListPage> createState() => _PicturesListPageState();
}

class _PicturesListPageState extends State<PicturesListPage> {
  late final TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  void _changeAction(String input) {
    if (input.length > 3) {
      //Call method from bloc to search
      DebugProvider.debugLog('Calling search method');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        GenericInputBox(
          textInputController: _inputController,
          width: MediaQuery.of(context).size.width * 0.9,
          title: AppLocalizations.of(context).search,
          enabled: true,
          leadIcon: null,
          onChangedAction: _changeAction,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.pictures.length,
            itemBuilder: (BuildContext context, int index) {
              return ApodCard(pictureOfTheDay: widget.pictures[index])
                  .animate(delay: Duration(milliseconds: 100 * index))
                  .slide(
                      begin: Offset.fromDirection(0, 1), curve: Curves.easeIn);
            },
          ),
        ),
      ],
    );
  }
}
