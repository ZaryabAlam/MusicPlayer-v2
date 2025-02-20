class SongsModel {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String uri;
  final Duration? duration;

  SongsModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.uri,
    required this.duration,
  });

  factory SongsModel.fromMap(Map<String, dynamic> map) {
    return SongsModel(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      album: map['album'],
      uri: map['uri'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'uri': uri,
      'duration':duration,
    };
  }
}