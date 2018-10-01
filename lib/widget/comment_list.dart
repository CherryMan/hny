import 'package:flutter/material.dart';

import 'comment_tile.dart';

class CommentList extends StatelessWidget {
  CommentList(this._commentIDs, {int depth: 0})
    : _depth = depth;

  final List<int> _commentIDs;
  final int _depth;

  @override
  Widget build(BuildContext _) => ListView.builder(
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: _commentIDs.length,

    itemBuilder: (ctx, i) {

      // Prevent the comment from being unloaded
      KeepAliveNotification(KeepAliveHandle())
        .dispatch(ctx);

      return CommentTile(_commentIDs[i], depth: _depth);
    },
  );
}
