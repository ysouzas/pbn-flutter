import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/controllers/team_controller.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/repositories/player_repository.dart';
import 'package:pbn_flutter/repositories/team_repository.dart';
import 'package:pbn_flutter/services/dio_service.dart';
import 'package:pbn_flutter/utils/environment.utils.dart';
import 'package:pbn_flutter/widgets/custom_list_card_widget.dart';
import 'package:share_plus/share_plus.dart';

class MainMobileScreen extends StatefulWidget {
  const MainMobileScreen({Key? key}) : super(key: key);

  @override
  State<MainMobileScreen> createState() => _MainMobileScreenState();
}

class _MainMobileScreenState extends State<MainMobileScreen> {
  List<String> selectedIds = [];
  bool isLoading = false;
  Environment environment =
      Environment(baseUrl: null, getPlayerURL: null, getTeamURL: null);

  late final PlayerController _playerController;
  late final TeamController _teamController;

  @override
  void initState() {
    super.initState();
    _playerController =
        PlayerController(PlayerRepository(DioService(environment)));
    _teamController = TeamController(TeamRepository(DioService(environment)));
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
                style: Theme.of(context).textTheme.headline6,
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
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: players.length,
                                itemBuilder: (_, index) => GestureDetector(
                                  onTap: () => selectId(players[index].id),
                                  child: CustomListCardWidget(
                                    player: players[index],
                                    isSelected: isIdSelected(players[index].id),
                                  ),
                                ),
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 16,
                                  );
                                },
                              )
                            : Container(
                                padding: const EdgeInsets.all(20),
                                child: Lottie.asset("assets/ball.json"),
                              );
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

  bool isIdSelected(String id) {
    return selectedIds.contains(id);
  }
}
