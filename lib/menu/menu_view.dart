import 'package:flutter/material.dart';
import 'package:metronome/player/player_view.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('目錄'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('播放器'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PlayerView())),
          ),
          ListTile(
            title: Text('節拍器'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
