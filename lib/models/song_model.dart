import 'package:on_audio_query/on_audio_query.dart';

class SongsModel {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String uri;
  final int? duration;

  SongsModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.uri,
    required this.duration,
  });

 factory SongsModel.fromJson(Map<String, dynamic> json) {
    return SongsModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      uri: json['uri'],
      duration: json['duration'],
    );
  }

  // Optional: Convert a SongModel object back to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'uri': uri,
      'duration': duration,
    };
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SongsModel && other.id == id;
  }

  // Override hashCode
  @override
  int get hashCode => id.hashCode;
}

SongsModel songModelToSongsModel(SongModel song) {
  return SongsModel(
    id: song.id.toString(),
    title: song.title,
    artist: song.artist ?? "Unknown Artist",
    album: song.album ?? "Unknown Album",
    uri: song.uri??"",
    duration: song.duration,
  );
}