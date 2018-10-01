import 'package:flutter/material.dart';

import '../hn/data.dart';
import '../widget/comment_list.dart';

class StoryView extends StatelessWidget {
  StoryView(this._story)
    : assert(_story != null);

  final Story _story;

  @override
  Widget build(BuildContext _) => Scaffold(
    body: CommentList(_story.kids),
  );
}
