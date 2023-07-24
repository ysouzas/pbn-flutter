import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/screens/shared/players_list_screen.dart';
import 'package:pbn_flutter/widgets/custom_floating_action_button_widget.dart';

class CustomListPlayersWidget extends StatefulWidget {
  const CustomListPlayersWidget({Key? key}) : super(key: key);

  @override
  State<CustomListPlayersWidget> createState() =>
      _CustomListPlayersWidgetState();
}

class _CustomListPlayersWidgetState extends State<CustomListPlayersWidget> {
  final PlayerController _playerController = GetIt.instance<PlayerController>();
  List<String> selectedIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<List<Player>?>(
                  valueListenable: _playerController.players,
                  builder: (_, players, __) {
                    return players != null
                        ? PlayerList(
                            players: players,
                            onTapGestureDetector: selectId,
                            selectedIds: selectedIds,
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton:
            CustomFloatingActionButtonWidget(selectedIds: selectedIds));
  }

  void selectId(String id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
  }
}
