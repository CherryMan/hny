import 'package:flutter/material.dart';

import '../hn/data.dart';
import 'story_tile.dart';

class StoryList extends StatelessWidget {
  StoryList(this._storyIDs);

  final List<int> _storyIDs;

  @override
  Widget build(BuildContext _) => ListView.builder(
    itemCount: _storyIDs.length,
    itemBuilder: (_, i) {
      return FutureBuilder<Story>(
        future: Story.fromID(_storyIDs[i]),
        builder: (_, snap) =>
          snap.hasData
          ? StoryTile(snap.data)
          : snap.hasError
          ? Text('ERROR: ${snap.error}')
          : StoryTile(null),
      );
    },
  );
}

