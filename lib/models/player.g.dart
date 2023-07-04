// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      name: json['name'] as String,
      id: json['id'] as String,
      score: (json['score'] as num).toDouble(),
      goalkeeper: json['goalkeeper'] as bool,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'score': instance.score,
      'goalkeeper': instance.goalkeeper,
    };
