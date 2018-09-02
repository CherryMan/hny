import 'package:flutter/material.dart';

import '../hn/data.dart';

class CommentTile extends StatelessWidget {
  CommentTile(this._comment);

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

  @override
  Widget build(BuildContext _) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top:2.0, bottom: 6.0),
              child: Text('${_comment.by}',   style: _infoStyle),
            ),
            Row(
              children: [
                Expanded(child: Text('${_comment.text}', style: _textStyle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
