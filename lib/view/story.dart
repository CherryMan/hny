import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'story/header.dart';
import 'story/comment_list.dart';
import '../hn/data.dart';


class StoryView extends StatelessWidget {
  StoryView(this._story)
    : assert(_story != null);

  final Story _story;

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSafeArea(
            sliver: SliverToBoxAdapter(
            child: StoryHeader(_story))),
          SliverToBoxAdapter(
            child: CommentList(_story.kids)),
        ],
      ),
    );
  }
}
