import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  final String? baseUrl;
  final String? getPlayerURL;
  final String? getTeamURL;

  Environment({
    String? baseUrl,
    String? getPlayerURL,
    String? getTeamURL,
  })  : baseUrl = baseUrl ?? dotenv.env['BASE_URL'],
        getPlayerURL = getPlayerURL ?? dotenv.env['GET_PLAYER_URL'],
        getTeamURL = getTeamURL ?? dotenv.env['GET_TEAM_URL'];
}
