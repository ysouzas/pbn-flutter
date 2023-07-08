import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  const MainWebScreen({Key? key}) : super(key: key);

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
    _loadBaseUrlFromStorage();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _checkInputText() {
    setState(() {
      _canSubmit = _textEditingController.text.isNotEmpty;
    });
  }

  Future<void> _loadBaseUrlFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString('baseUrl');

    if (baseUrl != null) {
      _textEditingController.text = baseUrl;
      _canSubmit = true;
      _submitText(baseUrl, context);
    }
  }

  Future<void> _submitText(String baseUrl, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseUrl', baseUrl);

    var environment = Environment(
      baseUrl: baseUrl,
      getPlayerURL: 'football_functions',
      getTeamURL: 'teams',
    );

    var dioService = DioService(environment);
    var playerRepository = PlayerRepository(dioService);
    var teamRepository = TeamRepository(dioService);

    _registerSingletons(
        environment, dioService, playerRepository, teamRepository);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const ListOfPlayerWeb()),
    );
  }

  void _registerSingletons(
    Environment environment,
    IDioService dioService,
    IPlayerRepository playerRepository,
    ITeamRepository teamRepository,
  ) {
    locator.registerLazySingleton<Environment>(() => environment);
    locator.registerLazySingleton<IDioService>(() => dioService);
    locator.registerLazySingleton<IPlayerRepository>(() => playerRepository);
    locator.registerLazySingleton<ITeamRepository>(() => teamRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Box Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Enter a Base URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _canSubmit
                  ? () => _submitText(_textEditingController.text, context)
                  : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
