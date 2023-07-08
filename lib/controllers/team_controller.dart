import 'package:pbn_flutter/models/team.dart';
import 'package:pbn_flutter/repositories/abstracts/iteam_repository.dart';

class TeamController {
  final ITeamRepository _teamRepository;

  TeamController(this._teamRepository);

  Future<List<Team>> getTeams(List<String> ids) async {
    return await _teamRepository.getTeams(ids);
  }

  Future<String> getTeamsAsStrings(List<String> ids) async {
    var teams = await getTeams(ids);

    var teamsToPrint = "";

    for (int i = 0; i < teams.length; i++) {
      var team = teams[i];
      teamsToPrint +=
          'Time ${i + 1} - Score: ${team.score.toStringAsFixed(2)}\n';

      for (var player in team.players) {
        teamsToPrint += '${player.name} - ${player.score.toStringAsFixed(2)}\n';
      }

      teamsToPrint += "-----------------------------------\n";
    }

    return teamsToPrint;
  }
}
