import 'package:flutter/material.dart';

import '../hn/hn.dart';
import 'home/body.dart';

class HomeView extends StatefulWidget {
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {

  var _src = StorySrc.Top;

  @override
  build(_) => Scaffold(

    // HomeViewBody contains the AppBar and the
    // StoryList. It handles opening and closing
    // the drawer.
    body: HomeViewBody(_src),

    drawer: Drawer(
      child: ListView(
        children: StorySrc.values.map(
          (v) => Builder(
            builder: (ctx) => ListTile(
              title: Text(
                storySrcName[v],
                style: TextStyle(fontSize: 18)),
              selected: _src == v,
              onTap: () {
                _selectStorySrc(v);
                Navigator.pop(ctx);
              }))
        ).toList(),
      ),
    ),
  );

  void _selectStorySrc(StorySrc s) {
    setState(() => _src = s);
  }
}
