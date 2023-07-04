import 'package:flutter/material.dart';
import 'package:pbn_flutter/repositories/player_repository.dart';

import '../models/player.dart';

class PlayerController {
  final PlayerRepository _playerRepository;

  PlayerController(this._playerRepository) {
    getPlayers();
  }

  ValueNotifier<List<Player>?> players = ValueNotifier<List<Player>?>(null);

  getPlayers() async {
    players.value = await _playerRepository.getPlayers();
  }
}
