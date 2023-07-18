import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/controllers/team_controller.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';
import 'package:pbn_flutter/repositories/abstracts/iteam_repository.dart';
import 'package:pbn_flutter/screens/shared/players_list_screen.dart';
import 'package:pbn_flutter/widgets/text_modal.dart';

class ListOfPlayerWeb extends StatefulWidget {
  const ListOfPlayerWeb({Key? key}) : super(key: key);

  @override
  State<ListOfPlayerWeb> createState() => _ListOfPlayerWebState();
}

class _ListOfPlayerWebState extends State<ListOfPlayerWeb> {
  final IPlayerRepository _playerRepository =
      GetIt.instance<IPlayerRepository>();
  final ITeamRepository _teamRepository = GetIt.instance<ITeamRepository>();

  List<String> selectedIds = [];
  bool isLoading = false;

  late final PlayerController _playerController;
  late final TeamController _teamController;

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController(_playerRepository);
    _teamController = TeamController(_teamRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? Container(
                      padding: const EdgeInsets.all(20),
                      child: Lottie.asset("assets/ball.json"),
                    )
                  : ValueListenableBuilder<List<Player>?>(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          var isEleven = selectedIds.length >= 22;

          final text =
              await _teamController.getTeamsAsStrings(selectedIds, isEleven);

          setState(() {
            isLoading = false;
          });

          showTextModal(context, text);
        },
        backgroundColor: const Color.fromARGB(255, 8, 106, 155),
        child: Text(selectedIds.length.toString()),
      ),
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
