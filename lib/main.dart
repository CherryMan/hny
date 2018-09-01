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

  @override
  Widget build(BuildContext _) => ListView.builder(
    itemCount: _storyIDs.length,
    itemBuilder: (_, i) {
      return FutureBuilder<Story>(
        future: Story.fromID(_storyIDs[i]),
        builder: (_, snap) =>
          snap.hasData
          ? StoryListTile(snap.data)
          : snap.hasError
          ? Text('ERROR: ${snap.error}')
          : StoryListTile(null),
      );
    },
  );
}

class StoryListTile extends StatelessWidget {
  StoryListTile(this._story);

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
