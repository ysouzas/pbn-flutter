import 'package:flutter/material.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';

import '../models/player.dart';

class PlayerController {
  final IPlayerRepository _playerRepository;

  PlayerController(this._playerRepository) {
    getPlayers();
  }

  ValueNotifier<List<Player>?> players = ValueNotifier<List<Player>?>(null);
  ValueNotifier<Player?> player = ValueNotifier<Player?>(null);

  getPlayers() async {
    players.value = await _playerRepository.getPlayers();
  }

  getPlayer(String id) async {
    player.value = await _playerRepository.getPlayer(id);
  }
}
