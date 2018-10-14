import 'dart:core';
import 'dart:async';

import 'package:json_annotation/json_annotation.dart';

import 'hn.dart';

part 'data.g.dart';

class Item {
  Item(this.id, int time, this.by, this.deleted)
    : this.time = DateTime.fromMillisecondsSinceEpoch(time * 1000);

  final int id;
  final DateTime time;
  final String by;

  @JsonKey(defaultValue: false)
  final bool deleted;
}

@JsonSerializable(createToJson: false)
class Story extends Item {
  Story(
    id, time, by, deleted,
    this.title,
    this.url,
    this.text,
    this.descendants,
    this.kids,
    this.score,
  ) : super(id, time, by, deleted);

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  /// Does not validate whether the ID points to a Story.
  static Future<Story> fromID(int n) async
    => getItem(n)
        .then((x) =>
          Story.fromJson(x));

  final String title;
  final String url;
  final String text;

  final int descendants;
  final List<int> kids;
  final int score;
}

@JsonSerializable(createToJson: false)
class Comment extends Item {
  Comment(
    id, time, by, deleted,
    this.text,
    this.parent,
    this.kids,
  ) : super(id, time, by, deleted);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  /// Does not validate whether the ID points to a Comment.
  static Future<Comment> fromID(int n) async
    => getItem(n)
        .then((x) =>
          Comment.fromJson(x));

  final String text;
  final int parent;
  final List<int> kids;
}
