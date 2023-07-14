import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';
import 'package:pbn_flutter/services/dio_service.dart';
import 'package:intl/intl.dart';

class PlayerRepository implements IPlayerRepository {
  final DioService _dioService;

  PlayerRepository(this._dioService);

  @override
  Future<List<Player>> getPlayers() async {
    var url = '/${_dioService.environment.getPlayersURL}';
    final result = await _dioService.getDio().get(url);

    var listOfPlayers =
        (result.data as List).map((value) => Player.fromJson(value)).toList();

    return listOfPlayers;
  }

  @override
  Future<Player> getPlayer(String id) async {
    var url = '/${_dioService.environment.getPlayerURL}';
    final result = await _dioService.getDio().get(url);

    var player = Player.fromJson(result.data);

    return player;
  }

  @override
  void addScore(String id, double score) async {
    var url = '/${_dioService.environment.addScoreUrl}';

    var now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    var rank = {
      'Score': score,
      'DayOfWeek': now.weekday - 1,
      'Date': formatted
    };

    await _dioService.getDio().post(url, data: {'Id': id, 'Rank': rank});

    await getPlayers();
    return;
  }
}
