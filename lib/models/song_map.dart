import 'package:on_audio_query/on_audio_query.dart';

Map<String, dynamic> songModelToMap(SongModel song) {
  return {
    'id': song.id,
    'title': song.title,
    'artist': song.artist,
    'album': song.album,
    'uri': song.uri,
    'duration': song.duration,
  };
}