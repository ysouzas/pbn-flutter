import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';
import 'package:pbn_flutter/repositories/abstracts/iteam_repository.dart';
import 'package:pbn_flutter/repositories/player_repository.dart';
import 'package:pbn_flutter/repositories/team_repository.dart';
import 'package:pbn_flutter/screens/web/list_player_web.screen.dart';
import 'package:pbn_flutter/services/abstracts/idio_service.dart';
import 'package:pbn_flutter/services/dio_service.dart';
import 'package:pbn_flutter/utils/environment.utils.dart';

GetIt locator = GetIt.instance;

class MainWebScreen extends StatefulWidget {
  const MainWebScreen({super.key});

  @override
  _MainWebScreenState createState() => _MainWebScreenState();
}

class _MainWebScreenState extends State<MainWebScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_checkInputText);
  }

  void _checkInputText() {
    setState(() {
      _canSubmit = _textEditingController.text.isNotEmpty;
    });
  }

  void _submitText() {
    final String baseUrl = _textEditingController.text;

    var environment = Environment(
      baseUrl: baseUrl,
      getPlayerURL: 'football_functions',
      getTeamURL: 'teams',
    );

    var dioService = DioService(environment);
    var playerReporitory = PlayerRepository(dioService);
    var teamReporitory = TeamRepository(dioService);

    locator.registerLazySingleton<Environment>(() => environment);
    locator.registerLazySingleton<IDioService>(() => dioService);
    locator.registerLazySingleton<IPlayerRepository>(() => playerReporitory);
    locator.registerLazySingleton<ITeamRepository>(() => teamReporitory);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListOfPlayerWeb()),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Box Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter some text',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _canSubmit ? _submitText : null,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
