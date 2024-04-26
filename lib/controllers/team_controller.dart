import 'package:pbn_flutter/models/enum/position.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/models/team.dart';
import 'package:pbn_flutter/repositories/abstracts/iteam_repository.dart';

class TeamController {
  final ITeamRepository _teamRepository;

  TeamController(this._teamRepository);

  Future<List<Team>> getTeams(List<String> ids, bool usePosition) async {
    return await _teamRepository.getTeams(ids, usePosition);
  }

  Future<String> getTeamsAsStrings(List<String> ids, bool usePosition,
      {bool showPosition = false}) async {
    var teams = await getTeams(ids, usePosition);

    var teamsToPrint = "";

    for (int i = 0; i < teams.length; i++) {
      var team = teams[i];

      if (i == 1) {
        teamsToPrint +=
            'Time ${i + 1} - CAMISA PBN/BENFICA/COLETE LARANJA - Score: ${team.score.toStringAsFixed(2)}\n';
      } else {
        if (teams.length == 2 && i == 0) {
          teamsToPrint +=
              'Time CAMISA PRETA - Score: ${team.score.toStringAsFixed(2)}\n';
        } else {
          teamsToPrint +=
              'Time ${i + 1} - Score: ${team.score.toStringAsFixed(2)}\n';
        }
      }

      var players = showPosition ? orderByPosition(team.players) : team.players;

      for (var player in players) {
        if (showPosition) {
          String positionDescription =
              positionDescriptions[player.position] ?? "";

          if (player.position < 999) {
            teamsToPrint +=
                '${player.name} - $positionDescription - ${player.score.toStringAsFixed(2)}\n';
          } else {
            teamsToPrint +=
                '${player.name} - ${player.score.toStringAsFixed(2)}\n';
          }
        } else {
          teamsToPrint +=
              '${player.name} - ${player.score.toStringAsFixed(2)}\n';
        }
      }

      teamsToPrint += "-----------------------------------\n";
    }

    return teamsToPrint;
  }
}
