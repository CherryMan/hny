import 'package:flutter/material.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext _) => MaterialApp(
    title: 'Hello World!',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomeView(),
  );
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext _) => Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: Text('Hello World!'),
    ),
  );
}
