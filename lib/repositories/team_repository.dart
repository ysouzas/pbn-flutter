import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pbn_flutter/models/team.dart';
import 'package:pbn_flutter/services/dio_service.dart';
import 'abstracts/iteam_repository.dart';

class TeamRepository implements ITeamRepository {
  final DioService _dioService;

  TeamRepository(this._dioService);

  @override
  Future<List<Team>> getTeams(List<String> ids) async {
    var url = '/${_dioService.environment?.getTeamURL}';
    final result = await _dioService.getDio().post(
          url,
          data: ids,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
        );

    var listOfTeams =
        (result.data as List).map((value) => Team.fromJson(value)).toList();

    return listOfTeams;
  }
}
