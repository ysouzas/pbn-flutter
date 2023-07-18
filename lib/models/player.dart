import 'package:json_annotation/json_annotation.dart';
part 'player.g.dart';

@JsonSerializable()
class Player {
  String name;
  String id;
  double score;
  int position;

  Player({
    required this.name,
    required this.id,
    required this.score,
    required this.position,
  });

  factory Player.fromJson(Map<String, dynamic> data) => _$PlayerFromJson(data);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}

List<Player> orderByPosition(List<Player> players) {
  players.sort((a, b) => a.position.compareTo(b.position));
  return players;
}
