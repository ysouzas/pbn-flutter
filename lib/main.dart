import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/repositories/player_repository.dart';
import 'package:pbn_flutter/services/dio_service.dart';

import 'models/player.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final PlayerController _controller =
      PlayerController(PlayerRepository(DioService()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<List<Player>?>(
      valueListenable: _controller.players,
      builder: (_, players, __) {
        return players != null
            ? ListView.builder(
                itemCount: players.length,
                itemBuilder: (_, index) => Text(players[index].name))
            : Container();
      },
    )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
