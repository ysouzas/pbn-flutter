import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/controllers/team_controller.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';
import 'package:pbn_flutter/repositories/abstracts/iteam_repository.dart';
import 'package:pbn_flutter/repositories/player_repository.dart';
import 'package:pbn_flutter/repositories/team_repository.dart';
import 'package:pbn_flutter/screens/shared/players_list_screen.dart';
import 'package:share_plus/share_plus.dart';

class ListOfPlayerWeb extends StatefulWidget {
  const ListOfPlayerWeb({super.key});

  @override
  State<ListOfPlayerWeb> createState() => _ListOfPlayerWebState();
}

class _ListOfPlayerWebState extends State<ListOfPlayerWeb> {
  final IPlayerRepository _playerRepository =
      GetIt.instance<IPlayerRepository>();
  final ITeamRepository _teamRepository = GetIt.instance<ITeamRepository>();

  List<String> selectedIds = <String>[];
  bool isLoading = false;

  late final PlayerController _controller = PlayerController(_playerRepository);

  late final TeamController _teamController = TeamController(_teamRepository);

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
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              isLoading == false
                  ? ValueListenableBuilder<List<Player>?>(
                      valueListenable: _controller.players,
                      builder: (_, players, __) {
                        return PlayerList(
                            players: players,
                            onTapGestureDetector: selectId,
                            selectedIds: selectedIds);
                      },
                    )
                  : Container(
                      padding: const EdgeInsets.all(20),
                      child: Lottie.asset("assets/ball.json"),
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
          var text = await _teamController.getTeamsAsStrings(selectedIds);

          setState(() {
            isLoading = false;
          });
          Share.share(text);
        },
        backgroundColor: const Color.fromARGB(255, 8, 106, 155),
        child: Text(selectedIds.length.toString()),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
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
