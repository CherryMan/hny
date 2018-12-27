import 'package:flutter/material.dart';

import '../../hn/hn.dart';
import 'story_list.dart';

final storySrcName = {
  StorySrc.Top:  'Top Stories',
  StorySrc.New:  'New Stories',
  StorySrc.Best: 'Best Stories',
  StorySrc.Ask:  'Ask HN',
  StorySrc.Show: 'Show HN',
  StorySrc.Job:  'Jobs',
};

/// Returns a Sliver to be used by a CustomScrollView.
class HomeViewBody extends StatelessWidget {
  HomeViewBody(this._src)
    : _future = getStories(_src);

  final StorySrc _src;
  final _future;

  @override
  build(BuildContext ctx) => CustomScrollView(
    slivers: [
      SliverAppBar(
        floating: true,
        title: Text(storySrcName[_src]),
      ),

      _createStoryList(),
    ]
  );

  // Returns a Sliver to be used in the CustomScrollView
  // in the build function.
  _createStoryList() => FutureBuilder<List<int>>(
    future: _future,
    builder: (_, snap) {
      switch (snap.connectionState) {
        case ConnectionState.waiting:
        case ConnectionState.active:
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));

        case ConnectionState.done:
          return StoryList(snap.data);

        case ConnectionState.none:
          return null; // shouldn't happen
      }
    }
  );
}
