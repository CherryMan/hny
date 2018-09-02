import 'package:flutter/material.dart';

import '../hn/data.dart';
import 'comment_tile.dart';

class CommentList extends StatelessWidget {
  CommentList(this._commentIDs, {int depth: 0})
    : _depth = depth;

  final List<int> _commentIDs;
  final int _depth;

  Widget _buildCommentThread(Comment c) {

    var comm = CommentTile(c);

    if (c.kids != null) {
      var subComments =
        Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CommentList(c.kids, depth: _depth + 1),
        );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          comm,
          subComments,
        ]
      );
    }

    return comm;
  }

  @override
  Widget build(BuildContext _) => ListView.builder(
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: _commentIDs.length,
    itemBuilder: (_, i) => FutureBuilder<Comment>(
      future: Comment.fromID(_commentIDs[i]),
      builder: (_, snap) {
        if      (snap.hasData)  return _buildCommentThread(snap.data);
        else if (snap.hasError) return Text('${snap.error}');
        else return Container(child: CircularProgressIndicator());
      },
    ),
  );
}
