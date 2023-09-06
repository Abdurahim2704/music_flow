import 'package:audio_picker/src/models/track.dart';
import 'package:audio_picker/src/services/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioQueryService {
  static void pickMp3File(List message) async {
    final List<Track> tracks = [];

    BackgroundIsolateBinaryMessenger.ensureInitialized(message[1]);

    if (await PermissionHandler.audioPermission()) {
      final OnAudioQuery audioQuery = OnAudioQuery();
      final List<SongModel> data = await audioQuery.querySongs();
      for (var e in data) {
        try {
          final name = e.title;
          final path = e.data;
          final duration = Duration(milliseconds: e.duration ?? 0);
          final image = await audioQuery.queryArtwork(e.id, ArtworkType.AUDIO);

          if (duration.inSeconds < 5) {
            continue;
          }

          tracks.add(
              Track(name: name, path: path, duration: duration, image: image));
        } catch (e) {
          continue;
        }
      }
    }
    message[0].send(tracks);
  }
}
