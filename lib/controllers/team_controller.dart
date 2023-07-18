import 'package:pbn_flutter/models/enum/position.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/models/team.dart';
import 'package:pbn_flutter/repositories/abstracts/iteam_repository.dart';

class TeamController {
  final ITeamRepository _teamRepository;

  TeamController(this._teamRepository);

  Future<List<Team>> getTeams(List<String> ids) async {
    return await _teamRepository.getTeams(ids);
  }

  Future<String> getTeamsAsStrings(List<String> ids, bool isEleven) async {
    var teams = await getTeams(ids);

    var teamsToPrint = "";

    for (int i = 0; i < teams.length; i++) {
      var team = teams[i];
      teamsToPrint +=
          'Time ${i + 1} - Score: ${team.score.toStringAsFixed(2)}\n';

      var players = orderByPosition(team.players).reversed;

      for (var player in players) {
        if (isEleven) {
          String positionDescription =
              positionDescriptions[player.position] ?? "";

          if (player.position < 4) {
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
