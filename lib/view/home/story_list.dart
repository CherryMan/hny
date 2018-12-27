import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'story_tile.dart';

/// Returns a SliverList to be used in a CustomScrollView.
class StoryList extends StatelessWidget {
  StoryList(this._storyIDs);

  final List<int> _storyIDs;

  @override
  Widget build(_) {
    final delegate = SliverChildBuilderDelegate(
      (ctx, i) {
        // If i is odd, then a divider is returned. Else
        // we return a StoryTile.

        if (i & 1 == 1) // if i is odd
          return Divider(height: 2.0, color: Colors.grey[400]);

        // Divide i by two, because we only want the pair i's
        else
          return StoryTile(_storyIDs[i >> 1]);
      },
      childCount: 2 * _storyIDs.length,
    );

    return SliverList(delegate: delegate);
  }
}
