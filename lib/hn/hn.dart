import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

const HN_API_URL     = 'https://hacker-news.firebaseio.com';
const HN_API_VERSION = 'v0';

enum StorySrc {
  Top,
  New,
  Best,
  Ask,
  Show,
  Job,
}

const _storyPath = {
  StorySrc.Top:  'topstories',
  StorySrc.New:  'newstories',
  StorySrc.Best: 'beststories',
  StorySrc.Ask:  'askstories',
  StorySrc.Show: 'showstories',
  StorySrc.Job:  'jobstories',
};

// Used to access the HN API. Must be initialized
// using the `initFirebase()` function.
FirebaseApp _app;
DatabaseReference _db;

// Initialize _db.
initFirebase() async {
  // Initialize only on first call
  if (_db != null) return;

  // Initialize the app
  _app = await FirebaseApp.configure(
    name: 'hny',
    options: const FirebaseOptions(
      // Although the HN API is public, the firebase library for
      // flutter requires the three following variables to be set
      // to non-null values, even if the values are meaningless.
      googleAppID: '_', // required due to an assertion in firebase
      apiKey:      '_', // required on Android
      gcmSenderID: '_', // required on iOS
    ),
  );

  // Initialize the database for accessing the HN API.
  _db = FirebaseDatabase(app: _app, databaseURL: HN_API_URL)
    .reference()
    .child(HN_API_VERSION);
}

// Query the root of the API and return the value.
Future<dynamic> query(String q) async {
  //initFirebase();
  return _db.child(q).once().then((DataSnapshot s) => s.value);
}

Future<Map<String, dynamic>> getItem(int n) async
  => query('item/$n')
      .then((x) => Map<String, dynamic>.from(x));

Future<List<int>> getStories(StorySrc s) async
  => query(_storyPath[s]).then((x) => x.cast<int>());

Future<String> getTitle(int i) async
  => await query('item/$i/title');
