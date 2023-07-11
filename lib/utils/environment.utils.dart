import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  final String? baseUrl;
  final String? getPlayersURL;
  final String? getTeamURL;
  final String? getPlayerURL;
  final String? addScoreUrl;

  Environment({
    String? baseUrl,
    String? getPlayerURL,
    String? getTeamURL,
    String? getPlayersURL,
    String? addScoreUrl,
  })  : baseUrl = baseUrl ?? dotenv.env['BASE_URL'],
        getPlayersURL = getPlayersURL ?? dotenv.env['GET_PLAYERS_URL'],
        getTeamURL = getTeamURL ?? dotenv.env['GET_TEAM_URL'],
        getPlayerURL = getPlayerURL ?? dotenv.env['GET_PLAYER_URL'],
        addScoreUrl = addScoreUrl ?? dotenv.env['ADD_SCORE_URL'];
}
