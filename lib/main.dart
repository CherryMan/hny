import 'package:flutter/material.dart';

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
