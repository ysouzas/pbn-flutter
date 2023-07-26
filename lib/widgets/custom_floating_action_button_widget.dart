import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/controllers/team_controller.dart';
import 'package:pbn_flutter/models/enum/position.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/widgets/text_modal.dart';

class CustomFloatingActionButtonWidget extends StatelessWidget {
  final List<String> selectedIds;
  final PlayerController _playerController = GetIt.instance<PlayerController>();
  final TeamController _teamController = GetIt.instance<TeamController>();

  CustomFloatingActionButtonWidget({
    required this.selectedIds,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showOptions(context);
      },
      backgroundColor: const Color.fromARGB(255, 8, 106, 155),
      child: Text(selectedIds.length.toString()),
    );
  }

  void showTextModal(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return TextModal(text: message);
      },
    );
  }

  void showOptions(BuildContext context) async {
    await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Generate Teams'),
              onTap: () async {
                EasyLoading.show();
                var isEleven = selectedIds.length >= 22;

                final text = await _teamController.getTeamsAsStrings(
                    selectedIds, isEleven);

                EasyLoading.dismiss();

                showTextModal(context, text);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Get Ranking'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Get Player By Position'),
              onTap: () {
                EasyLoading.show();

                var players = orderByPosition(_playerController.players.value!
                    .where((element) => element.position != 999)
                    .toList());

                var text = "";

                for (var player in players) {
                  String positionDescription =
                      positionDescriptions[player.position] ?? "";

                  text += '${player.name} - $positionDescription\n';
                }

                EasyLoading.dismiss();

                showTextModal(context, text);
              },
            ),
          ],
        );
      },
    );
  }
}
