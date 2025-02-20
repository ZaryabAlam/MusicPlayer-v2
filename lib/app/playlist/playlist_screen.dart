import "package:flutter/material.dart";

import "../../components/common_text.dart";

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: CommonText(text: "Playlist", fontSize: 22) ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}