import 'package:flutter/material.dart';

import '../hn/data.dart';

class StoryTile extends StatelessWidget {
  StoryTile(this._story);

  final Story _story;

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

  Widget _titleWidget() => Container(
    alignment: Alignment.centerLeft,
    child: Text(
      _story?.title ?? '...',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
      ),
    ),
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
          Flexible(
            child: mainColumn,
          ),
        ],
      );

    return mainRow;
  }

  @override
  Widget build(BuildContext _) =>
    Card(
      margin: const EdgeInsets.all(2.5),

      child: InkWell(
        onTap: () {},

        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: _cardContents(),
        ),
      ),
    );
}
