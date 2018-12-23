import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html_unescape/html_unescape_small.dart';

import 'comment_list.dart';
import '../../hn/data.dart';

class CommentTile extends StatefulWidget {
  CommentTile(this._commentID, {int depth: 0})
    : _depth = depth;

  final int _commentID;
  final int _depth;

  Widget _commTile;
  Widget _subComments;
  bool _collapsed = false;

  @override
  _CommentTile createState() => _CommentTile(_commentID, _depth);
}

class _CommentTile extends State<CommentTile> {
  _CommentTile(this._commentID, this._depth);

  final int _depth;
  final int _commentID;

  initState() {
    super.initState();

    if (widget._commTile == null) {
      // Create placeholder
      widget._commTile = _buildTile(null);

      // Get comment data from server and rebuild tile.
      Comment.fromID(this._commentID).then((c) {
        widget._commTile = _buildTile(c);

        // Build the subcomments
        if (c.kids != null)
          widget._subComments ??= CommentList(c.kids, depth: _depth + 1);

        if (this.mounted)
          setState(() {});
      });
    }
  }

  // If c is null, this creates a placeholder tile.
  Widget _buildTile(Comment c) {
    return
      Card(
        elevation: .5,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          child: _CommentData(c),
        ),
      );
  }

  Widget _buildThread() {
    var comm = widget._commTile;

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

    // Allows the tile to expand horizontally
    comm =
      Row(
        children: [ Expanded(child: comm) ],
      );


    // Draw the subcomments if necessary
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

  final _textStyleItalic = const
    TextStyle(
      fontStyle: FontStyle.italic,
    );

  final _textStyleLink = const
    TextStyle(
      color: Colors.blue,
    );

  final _textStyleCode =
    TextStyle(
      fontFamily: Platform.isIOS ? 'Menlo' : 'monospace',
    );

  // Assumes that the string has no errors.
  Text _formatText(String s) {
    var pars =
      s.replaceAll('<p>', '\n\n') // Split paragraphs

      // Handle italics and links
      // On HN, italics, links, and code blocks overlapping are
      // not an issue, so they are handled separately.
      // The way codeblocks work is also very hardcoded, and
      // should probably be changed.
      .split(RegExp(r'(?=<(i|a.*?)>)|<\/(i|a)>|(?=<pre><code>)|<\/code><\/pre>'))
      .map((s) {

        // escaped text
        var esc = HtmlUnescape().convert(s);

        // italic
        if (s.startsWith('<i>')) {
          return TextSpan(text: esc.substring(3), style: _textStyleItalic);

        // codeblock
        } else if (s.startsWith('<pre><code>')) {
          return TextSpan(text: esc.substring(11), style: _textStyleCode);

        // link
        } else if (s.startsWith('<a')) {
          var exp = RegExp(r'<a\s+href="(.+?)".+?>(.*)');
          var m = exp.firstMatch(esc);
          return
            TextSpan(
              text: m.group(2),
              style: _textStyleLink,
              recognizer: new TapGestureRecognizer()
                ..onTap = () => launch(m.group(1)),
            );

        // default
        } else {
          return TextSpan(text: esc);
        }
      })

      .toList();

    return
      Text.rich(
        TextSpan(children: pars, style: _textStyle)
      );
  }

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
      _formatText(text),
    );

    return
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: colItems,
      );
  }
}
