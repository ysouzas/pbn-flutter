import 'package:pbn_flutter/models/team.dart';

abstract class ITeamReporitory {
  Future<List<Team>> getTeams(List<String> ids);
}
