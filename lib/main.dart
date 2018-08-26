import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

const HN_API_URL     = 'https://hacker-news.firebaseio.com';
const HN_API_VERSION = 'v0';

// to access HN API
DatabaseReference db;

// Cache story IDs
List<dynamic> storyIDs;

void main() async {

  // Initialize the app
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'hny',
    options: const FirebaseOptions(
      // Although the HN API is public, the firebase library for
      // flutter requires the three following variables to be set
      // to non-empty values, even if the values are meaningless.
      googleAppID: '_', // required due to an assertion in firebase
      apiKey:      '_', // required on Android
      gcmSenderID: '_', // required on iOS
    ),
  );

  // Initialize the database for accessing the HN API.
  db = FirebaseDatabase(
    app: app,
    databaseURL: HN_API_URL,
  ).reference().child(HN_API_VERSION);

  runApp(App());
}

Future<dynamic> queryHN(String q) async =>
  db.child(q).once().then((DataSnapshot s) => s.value);

Future<String> getTitle(int index) async {
  // Memoize the request
  if (storyIDs == null)
    await queryHN('topstories').then((s) => storyIDs = s);

  return queryHN('item/${storyIDs[index]}/title')
    .then((s) => s);
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
    body: Container(
      child: StoryList(),
    ),
  );
}

class StoryList extends StatelessWidget {

  // Placeholder widget before story info has been loaded
  static final _placeholder = Container(
    alignment: Alignment.centerLeft,
    child: Text('...'),
  );

  @override
  Widget build(BuildContext _) => ListView.builder(
    itemBuilder: (ctx, i) => ListTile(
      title: FutureBuilder<String>(
        future: getTitle(i),
        builder: (ctx, snap) =>
          snap.hasData
            ? Text('${snap.data}')
          : snap.hasError
            ? Text('${snap.error}')
          : _placeholder,
      ),
    ),
  );
}
