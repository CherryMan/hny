import 'package:flutter/material.dart';

import '../hn/data.dart';
import 'comment_list.dart';

class CommentTile extends StatefulWidget {
  CommentTile(this._commentID, {int depth: 0})
    : _depth = depth;

  final int _commentID;
  final int _depth;

  Comment _comment;
  Widget _subComments;
  bool _collapsed = false;

  @override
  _CommentTile createState() => _CommentTile(_commentID, _depth);
}

class _CommentTile extends State<CommentTile> {
  _CommentTile(this._commentID, this._depth);

  final int _depth;
  final int _commentID;

  Comment _comment;

  initState() {
    super.initState();

    if (widget._comment == null) {

      Comment.fromID(this._commentID).then((c) {
        widget._comment = c;

        // Build the subcomments
        if (c.kids != null)
          widget._subComments ??= CommentList(c.kids, depth: _depth + 1);

        if (this.mounted)
          setState(() {});
      });
    }
  }

  Widget _buildTile(Comment c) {

    // A Container containing the CommentData
    Widget comm =
      Container(
        margin: const EdgeInsets.all(12.0),
        child: _CommentData(c),
      );

    // If there are child comments, add an InkWell
    // to toggle whether the thread is collapsed.
    if (widget._subComments != null) {
      comm =
        InkWell(
          child: comm,
          onTap: () {
            setState(() => widget._collapsed = !widget._collapsed);
          },
        );
    }

    return Card(child: comm, elevation: .5);
  }

  Widget _buildThread() {
    var comm =
      Row(
        children: [ Expanded(child: _buildTile(widget._comment)) ],
      );

    if (!widget._collapsed && widget._subComments != null) {

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
  _CommentData(this._comment); // _comment can be null

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
