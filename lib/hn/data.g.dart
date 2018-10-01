// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
      json['id'],
      json['time'],
      json['by'],
      json['deleted'] ?? false,
      json['title'] as String,
      json['url'] as String,
      json['text'] as String,
      json['descendants'] as int,
      (json['kids'] as List)?.map((e) => e as int)?.toList(),
      json['score'] as int);
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
      json['id'],
      json['time'],
      json['by'],
      json['deleted'] ?? false,
      json['text'],
      json['parent'] as int,
      (json['kids'] as List)?.map((e) => e as int)?.toList());
}
