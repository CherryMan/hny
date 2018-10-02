import 'package:flutter/material.dart';

import 'comment_tile.dart';

class CommentList extends StatelessWidget {
  CommentList(this._commentIDs, {int depth: 0})
    : comments =
        _commentIDs.map((id) => CommentTile(id, depth: depth)).toList();

  final List<int> _commentIDs;
  final List<Widget> comments;

  @override
  Widget build(BuildContext _) => ListView.builder(
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: _commentIDs.length,

    itemBuilder: (ctx, i) {
        return comments[i];
    },
  );
}
