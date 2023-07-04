import 'package:pbn_flutter/models/player.dart';

abstract class IPlayerReporitory {
  Future<List<Player>> getPlayers();
}
