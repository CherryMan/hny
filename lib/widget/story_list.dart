import 'package:flutter/material.dart';

import 'story_tile.dart';

class StoryList extends StatelessWidget {
  StoryList(this._storyIDs);

  final List<int> _storyIDs;

  @override
  Widget build(BuildContext _) => ListView.builder(
    itemCount: _storyIDs.length,
    itemBuilder: (_, i) {

      return StoryTile(_storyIDs[i]);
    },
  );
}

