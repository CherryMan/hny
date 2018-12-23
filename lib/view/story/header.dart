import 'dart:core';
import 'dart:ui' show Size;
import 'package:flutter/material.dart';

import '../../hn/data.dart';


class StoryHeader extends StatelessWidget {
  StoryHeader(this._story)
    : assert(_story != null);

  final Story _story;

  final _scoreStyle = const
    TextStyle(
      fontSize: 30.0,
    );

  static final _infoSize = 16.0;

  final _infoStyle =
    TextStyle(
      fontSize: _infoSize,
    );

  final _titleStyle = const
    TextStyle(
      fontSize: 20.0,
    );

  @override
  Widget build(BuildContext ctx) {
    final title = Text(_story.title, style: _titleStyle);
    final author = Text(_story.by);

    var link;
    if (_story.url != null) {
      final uri = Uri.parse(_story.url).origin;
      link = Text(
        uri,
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
      );
    }

    final info = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.comment, size: _infoSize),
        Text('${_story.descendants}', style: _infoStyle),
        Icon(Icons.arrow_upward, size: _infoSize),
        Text('${_story.score}', style: _infoStyle),
      ],
    );

    // All of the content of the header
    Widget content = Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        info,

        // Title and shortlink
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              child: title,
              padding: const EdgeInsets.only(top: 10.0, bottom: 2.0)
            ),
            link,
          ],
        ),

        // Author
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            author,
          ],
        ),

      ], // Column children
    ); // Column

    // Surround the content with a PreferredSize and Container
    content = PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: content,
      ),
    );

    return Material(
      elevation: 0.5,
      shape: Border(),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: content,
      ),
    );
  }
}
