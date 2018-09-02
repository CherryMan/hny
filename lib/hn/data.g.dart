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
      json['title'] as String,
      json['url'] as String,
      json['text'] as String,
      json['descendants'] as int,
      (json['kids'] as List)?.map((e) => e as int)?.toList(),
      json['score'] as int);
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'time': instance.time?.toIso8601String(),
      'by': instance.by,
      'title': instance.title,
      'url': instance.url,
      'text': instance.text,
      'descendants': instance.descendants,
      'kids': instance.kids,
      'score': instance.score
    };

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
      json['id'],
      json['time'],
      json['by'],
      json['text'] as String,
      json['parent'] as int,
      (json['kids'] as List)?.map((e) => e as int)?.toList());
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'time': instance.time?.toIso8601String(),
      'by': instance.by,
      'text': instance.text,
      'parent': instance.parent,
      'kids': instance.kids
    };
