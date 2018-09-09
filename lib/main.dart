import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'hn/data.dart';

import 'hn/hn.dart';
import 'view/home.dart';

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
