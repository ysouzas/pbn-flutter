import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/controllers/team_controller.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';
import 'package:pbn_flutter/repositories/abstracts/iteam_repository.dart';
import 'package:pbn_flutter/screens/shared/players_list_screen.dart';
import 'package:share_plus/share_plus.dart';

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
              const SizedBox(
                height: 40,
              ),
              Text(
                "Players",
                style: Theme.of(context).textTheme.titleLarge,
              ),
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

          final text = await _teamController.getTeamsAsStrings(selectedIds);

          setState(() {
            isLoading = false;
          });

          Share.share(text);
        },
        backgroundColor: const Color.fromARGB(255, 8, 106, 155),
        child: Text(selectedIds.length.toString()),
      ),
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
