import 'package:flutter/material.dart';

import '../hn/hn.dart';
import '../widget/story_list.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext _) => Scaffold(
    appBar: AppBar(
      title: Text('Stories'),
    ),
    body: FutureBuilder<List<int>>(
      future: getStories(StorySrc.Top),
      builder: (_, snap) =>
        snap.hasData
          ? Container(child: StoryList(snap.data))
        : snap.hasError
          ? Center(child: Text('ERROR: ${snap.error}'))
        : Center(child: CircularProgressIndicator())
      ,
    ),
  );
}
