import 'package:pbn_flutter/models/player.dart';

abstract class IPlayerRepository {
  Future<List<Player>> getPlayers();
  Future<Player> getPlayer(String id);
  void addScore(String id, double score);
}
