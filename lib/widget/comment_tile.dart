import 'package:flutter/material.dart';

import '../hn/data.dart';
import 'comment_list.dart';

class CommentTile extends StatelessWidget {
  CommentTile(this._commentID, {int depth: 0})
    : _depth = depth;

  final int _depth;
  final int _commentID;

  Comment _comment;

  final _infoStyle = const
    TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
    );

  final _textStyle = const
    TextStyle(
      fontWeight: FontWeight.normal,
    );

  Widget _buildTile() {

    String author = '${_comment?.by}'   ?? '...';
    String text   = '${_comment?.text}' ?? '...';

    final col =
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top:2.0, bottom: 6.0),
            child: Text(author,   style: _infoStyle),
          ),
          Text(text, style: _textStyle),
        ],
      );

    return Card(
      child: Container(
        margin: const EdgeInsets.all(12.0),
        child: col,
      ),
    );
  }

  Widget _buildSubComments(List<int> kids) =>
    Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: CommentList(kids, depth: _depth + 1),
    );

  Widget _buildThread(Comment c) {

    var comm =
      Row(
        children: [ Expanded(child: _buildTile()) ],
      );

    if (c?.kids != null) {
      var subComments = _buildSubComments(c.kids);

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
  Widget build(BuildContext _) {

    var fb =
      FutureBuilder<Comment>(
        future: Comment.fromID(_commentID),
        builder: (_, snap) {
          if (snap.hasData) {
            _comment = snap.data;
            return _buildThread(snap.data);
          } else if (snap.hasError) {
            return Text('${snap.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      );

    return fb;
  }
}
