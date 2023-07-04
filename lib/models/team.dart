import 'package:json_annotation/json_annotation.dart';
import 'package:pbn_flutter/models/player.dart';
part 'team.g.dart';

@JsonSerializable()
class Team {
  List<Player> players;
  double score;

  Team({
    required this.players,
    required this.score,
  });

  factory Team.fromJson(Map<String, dynamic> data) => _$TeamFromJson(data);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
