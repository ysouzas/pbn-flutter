import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'MY_FALLBACK';
  static String get getPlayerURL =>
      dotenv.env['GET_PLAYER_URL'] ?? 'MY_FALLBACK';
  static String get getTeamURL => dotenv.env['GET_TEAM_URL'] ?? 'MY_FALLBACK';
}
