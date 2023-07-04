import 'package:json_annotation/json_annotation.dart';
part 'player.g.dart';

@JsonSerializable()
class Player {
  String name;
  String id;
  double score;
  bool goalkeeper;

  Player({
    required this.name,
    required this.id,
    required this.score,
    required this.goalkeeper,
  });

  factory Player.fromJson(Map<String, dynamic> data) => _$PlayerFromJson(data);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
