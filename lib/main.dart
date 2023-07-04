import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/controllers/team_controller.dart';
import 'package:pbn_flutter/repositories/player_repository.dart';
import 'package:pbn_flutter/repositories/team_repository.dart';
import 'package:pbn_flutter/services/dio_service.dart';
import 'package:pbn_flutter/widgets/custom_list_card_widget.dart';
import 'package:share_plus/share_plus.dart';

import 'models/player.dart';

Future<void> main() async {
  await dotenv.load(mergeWith: Platform.environment);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PBN',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> selectedIds = <String>[];

  final PlayerController _controller =
      PlayerController(PlayerRepository(DioService()));

  final TeamController _teamController =
      TeamController(TeamRepository(DioService()));

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
              ValueListenableBuilder<List<Player>?>(
                valueListenable: _controller.players,
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
                                isSelected: isIdSelected(players[index].id)),
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
          var text = await _teamController.getTeamsAsStrings(selectedIds);
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

  bool isIdSelected(String id) {
    return selectedIds.contains(id);
  }
}
