import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';
import 'package:pbn_flutter/services/dio_service.dart';

class PlayerRepository implements IPlayerRepository {
  final DioService _dioService;

  PlayerRepository(this._dioService);

  @override
  Future<List<Player>> getPlayers() async {
    var url = '/${_dioService.environment.getPlayerURL}';
    final result = await _dioService.getDio().get(url);

    var listOfPlayers =
        (result.data as List).map((value) => Player.fromJson(value)).toList();

    return listOfPlayers;
  }
}
