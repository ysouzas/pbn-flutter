import 'package:pbn_flutter/models/team.dart';

abstract class ITeamRepository {
  Future<List<Team>> getTeams(List<String> ids);
}
