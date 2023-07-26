import 'package:get_it/get_it.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/controllers/team_controller.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';
import 'package:pbn_flutter/repositories/abstracts/iteam_repository.dart';
import 'package:pbn_flutter/repositories/player_repository.dart';
import 'package:pbn_flutter/repositories/team_repository.dart';
import 'package:pbn_flutter/services/abstracts/idio_service.dart';
import 'package:pbn_flutter/services/dio_service.dart';
import 'package:pbn_flutter/utils/environment.utils.dart';

GetIt locator = GetIt.instance;

class DependencyInjection {
  static void _setup(Environment environment) {
    var dioService = DioService(environment);
    var playerRepository = PlayerRepository(dioService);
    var teamRepository = TeamRepository(dioService);
    var playerController = PlayerController(playerRepository);
    var teamController = TeamController(teamRepository);

    locator.registerLazySingleton<Environment>(() => environment);
    locator.registerLazySingleton<IDioService>(() => dioService);
    locator.registerLazySingleton<IPlayerRepository>(() => playerRepository);
    locator.registerLazySingleton<ITeamRepository>(() => teamRepository);
    locator.registerLazySingleton<PlayerController>(() => playerController);
    locator.registerLazySingleton<TeamController>(() => teamController);
  }

  static void setupMobile() {
    var environment =
        Environment(baseUrl: null, getPlayerURL: null, getTeamURL: null);

    _setup(environment);
  }

  static void setupWeb(String baseUrl) {
    var environment = Environment(
        baseUrl: baseUrl,
        getPlayerURL: 'player',
        getTeamURL: 'teams',
        getPlayersURL: 'football_functions',
        addScoreUrl: 'rank',
        getRanking: 'ranking');

    _setup(environment);
  }
}
