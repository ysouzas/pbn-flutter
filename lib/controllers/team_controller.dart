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
    var teamsAsString = '';

    for (int i = 0; i < teams.length; i++) {
      var team = teams[i];
      var teamHeader = _generateTeamHeader(team, i,teams.length);
      teamsAsString += '$teamHeader\n';
      teamsAsString += _generatePlayersInfo(team, showPosition);
      teamsAsString += '-----------------------------------\n';
    }
    
    return teamsAsString;
  }

  String _generateTeamHeader(Team team, int index, int teamsLength) {
    if (index == 1) {
      return 'Time ${index + 1} - CAMISA PBN/BENFICA/COLETE LARANJA - Score: ${team.score.toStringAsFixed(2)}';
    } else {
      if (index == 0 && teamsLength == 2) {
        return 'Time CAMISA PRETA - Score: ${team.score.toStringAsFixed(2)}';
      } else {
        return 'Time ${index + 1} - Score: ${team.score.toStringAsFixed(2)}';
      }
    }
  }

  String _generatePlayersInfo(Team team, bool showPosition) {
    var playersInfo = '';
    var positionCount = {};

    for (var player in team.players) {
      if (showPosition) {
        var positionDescription = positionDescriptions[player.position] ?? ''; 
        var playerInfo = player.position < 999
            ? '${player.name} - $positionDescription - ${player.score.toStringAsFixed(2)}'
            : '${player.name} - ${player.score.toStringAsFixed(2)}';
        playersInfo += '$playerInfo\n';
        positionCount[player.position] =
            (positionCount[player.position] ?? 0) + 1; // Use player.position as key
      } else {
        var playerInfo = '${player.name} - ${player.score.toStringAsFixed(2)}';
        playersInfo += '$playerInfo\n';
      }
    }

    // Sort positionCount by position numbers
    var sortedPositionCount = Map.fromEntries(positionCount.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key)));

    var positionsLine = sortedPositionCount.entries
        .map((entry) => '${positionDescriptions[entry.key] ?? ''}: ${entry.value}')
        .join('; ');
    playersInfo += '$positionsLine\n';

    return playersInfo;
  }
}