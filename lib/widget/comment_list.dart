import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'comment_tile.dart';

class CommentList extends StatelessWidget {
  CommentList(this._commentIDs, {int depth: 0})
    : _depth = depth,
      _comments = List(_commentIDs.length);

  final int _depth;
  final List<int> _commentIDs;
  final List<CommentTile> _comments; // cached comment tiles

  @override build(BuildContext _) {

    // Delegate that builds every comment in the list
    final delegate = SliverChildBuilderDelegate(
      (ctx, i) {
        _comments[i] ??= CommentTile(_commentIDs[i], depth: _depth);
        return _comments[i];
      },
      childCount: _commentIDs.length,
    );

    final list = CustomScrollView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        SliverList(delegate: delegate),
      ],
    );

    // Indent the list if it's nested
    return
      _depth > 0
      ? Padding(child: list, padding: const EdgeInsets.only(left: 15.0))
      : list;
  }
}
