import 'dart:async';

import 'package:json_annotation/json_annotation.dart';

import 'hn.dart';

part 'data.g.dart';

class Item {
  Item(this.id, int time, this.by)
    : this.time = DateTime.fromMillisecondsSinceEpoch(time * 1000);

  final int id;
  final DateTime time;
  final String by;
}

@JsonSerializable()
class Story extends Item {
  Story(
    id, time, by,
    this.title,
    this.url,
    this.text,
    this.descendants,
    this.kids,
    this.score,
  ) : super(id, time, by);

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  static Future<Story> fromID(int n) async
    => getItem(n)
        .then((x) =>
          Story.fromJson(x)
  );

  final String title;
  final String url;
  final String text;

  final int descendants;
  final List<int> kids;
  final int score;
}

@JsonSerializable(nullable: false)
class Comment extends Item {
  Comment(
    id, time, by,
    this.text,
    this.parent,
    this.kids,
  ) : super(id, time, by);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  final String text;
  final int parent;
  final List<int> kids;
}
