import 'package:pbn_flutter/models/player.dart';

abstract class IPlayerRepository {
  Future<List<Player>> getPlayers();
}
