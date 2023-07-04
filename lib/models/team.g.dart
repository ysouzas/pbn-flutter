// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'players': instance.players,
      'score': instance.score,
    };
