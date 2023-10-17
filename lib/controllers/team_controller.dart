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

  Future<String> getTeamsAsStrings(List<String> ids, bool usePosition) async {
    var teams = await getTeams(ids, usePosition);

    var teamsToPrint = "";

    for (int i = 0; i < teams.length; i++) {
      var team = teams[i];
      teamsToPrint +=
          'Time ${i + 1} - Score: ${team.score.toStringAsFixed(2)}\n';

      var players = usePosition ? orderByPosition(team.players) : team.players;

      for (var player in players) {
        if (usePosition) {
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
