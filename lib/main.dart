import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'hn/hn.dart';
import 'hn/data.dart';

void main() async {
  await initFirebase();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext _) => MaterialApp(
    title: 'hny',
    theme: ThemeData(
      primaryColor: Colors.grey[50],
      accentColor: Colors.orange[100],
    ),
    home: HomeView(),
  );
}

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

class StoryList extends StatelessWidget {
  StoryList(this._storyIDs);

  final List<int> _storyIDs;

  // Placeholder widget before story info has been loaded
  static final _placeholder = Container(
    alignment: Alignment.centerLeft,
    child: Text('...'),
  );

  @override
  Widget build(BuildContext _) => ListView.builder(
    itemCount: _storyIDs.length,
    itemBuilder: (_, i) => FutureBuilder<Story>(
      future: Story.fromID(_storyIDs[i]),
      builder: (_, snap) =>
        snap.hasData
        ? StoryListTile(snap.data, i)
        : snap.hasError
        ? Text('ERROR: ${snap.error}')
        : _placeholder,
    ),
  );
}

class StoryListTile extends StatelessWidget {
  StoryListTile(this._story, this._number);

  final int _number;
  final Story _story;

  @override
  Widget build(BuildContext _) => ListTile(
    leading: Text(
      '${_number}',
      style: TextStyle(
        fontSize: 25.0,
      ),
    ),
    title: Text(_story.title),
    subtitle: Text(_story.by),
  );
}
