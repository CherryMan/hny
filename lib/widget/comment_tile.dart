import 'package:flutter/material.dart';

import '../hn/data.dart';
import 'comment_list.dart';

class CommentTile extends StatefulWidget {
  CommentTile(this._commentID, {int depth: 0})
    : _depth = depth;

  final int _commentID;
  final int _depth;

  Comment _comment;
  Widget _tile;
  Widget _subComments;

  @override
  _CommentTile createState() => _CommentTile(_commentID, _depth);
}

class _CommentTile extends State<CommentTile> {
  _CommentTile(this._commentID, this._depth);

  final int _depth;
  final int _commentID;

  Comment _comment;
  bool _collapsed = false;

  initState() {
    super.initState();

    if (widget._comment == null) {

      widget._tile = _buildTile(null); // Placeholder

      Comment.fromID(this._commentID).then((c) {
        widget._comment = c;
        widget._tile = _buildTile(c);

        if (c.kids != null)
          widget._subComments ??= _buildSubComments(c.kids);

        if (this.mounted)
          setState(() {});
        //if (this.mounted) _setComment(c);
      });
    }
  }

  Widget _buildTile(Comment c) =>
    Card(
      child: InkWell(
        onTap: () {
          setState(() => _collapsed = !_collapsed);
        },

        child: Container(
          margin: const EdgeInsets.all(12.0),
          child: _CommentData(c),
        ),
      ),
    );

  Widget _buildSubComments(List<int> kids) =>
    Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: CommentList(kids, depth: _depth + 1),
    );

  Widget _buildThread() {
    var comm =
      Row(
        children: [ Expanded(child: widget._tile) ],
      );

    if (!_collapsed && widget._subComments != null) {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          comm,
          widget._subComments,
        ]
      );
    }

    return comm;
  }

  @override
  Widget build(BuildContext ctx) {

    // Prevent the comment from being unloaded
    KeepAliveNotification(KeepAliveHandle())
      .dispatch(ctx);

    return _buildThread();
  }
}

class _CommentData extends StatelessWidget {
  _CommentData(this._comment);

  final Comment _comment;

  final _infoStyle = const
    TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
    );

  final _textStyle = const
    TextStyle(
      fontWeight: FontWeight.normal,
    );

  Widget build(BuildContext _) {
    String author, text;

    // Widgets for the column that stores the info and comment text
    var colItems = <Widget>[];

    if (_comment == null) {
      author = '...';
      text   = '...';
    } else if (_comment.deleted) {
      text   = '[deleted]';
    } else {
      author = _comment.by;
      text   = _comment.text;
    }

    if (author != null) {
      colItems.add(
        Container(
          padding: const EdgeInsets.only(top:2.0, bottom: 6.0),
          child: Text(author, style: _infoStyle),
        ),
      );
    }

    colItems.add(
      Text(text, style: _textStyle),
    );

    return
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: colItems,
      );
  }
}
