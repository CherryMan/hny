import 'package:flutter/material.dart';

import 'comment_tile.dart';

class CommentList extends StatelessWidget {
  CommentList(this._commentIDs, {int depth: 0})
    : _depth = depth,
      _comments = List(_commentIDs.length);

  final int _depth;
  final List<int> _commentIDs;
  final List<Widget> _comments;

  @override
  Widget build(BuildContext _) => ListView.builder(
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: _commentIDs.length,
    padding: _depth != 0 ? const EdgeInsets.only(left: 15.0) : null,

    itemBuilder: (ctx, i) {
      _comments[i] ??= CommentTile(_commentIDs[i], depth: _depth);
      return _comments[i];
    },
  );
}
