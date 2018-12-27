import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../hn/data.dart';
import '../story.dart';

class StoryTile extends StatefulWidget {
  StoryTile(this._storyID);
  int _storyID;

  _StoryTile createState() => _StoryTile(_storyID);
}

class _StoryTile extends State<StoryTile> with SingleTickerProviderStateMixin {
  _StoryTile(this._storyID);

  final int _storyID;
  Story _story;

  final _titleStyle = const
    TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
    );

  final _byStyle = const
    TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w300,
    );

  // Generate what the card will contain
  Widget _cardContents() {
    var infoRow =
      Row(
        children: <Widget>[
          Text(_story?.by ?? '...', style: _byStyle),
        ],
      );

    // Contains post title and info
    var mainColumn = 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(_story?.title ?? '...', style: _titleStyle),
          ),
          infoRow,
        ],
      );

    // Contains the column with title and info
    var mainRow = 
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,

        children: <Widget>[
          Expanded(
            child: mainColumn,
          ),
        ],
      );

    return mainRow;
  }

  Widget _buildTile(BuildContext ctx) =>
    InkWell(
      onTap: () {
        if (_story != null) {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (ctx) => StoryView(_story)),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: _cardContents(),
      ),
    );

  @override
  Widget build(BuildContext ctx) {

    // KeepAlive if at deepest comment
    if (_story?.kids == null)
      KeepAliveNotification(KeepAliveHandle()).dispatch(ctx);

    return
      FutureBuilder<Story>(
        future: Story.fromID(this._storyID),
        builder: (ctx, snap) {
          if (snap.hasData) _story = snap.data;

          return _buildTile(ctx);
        },
      );
  }
}
