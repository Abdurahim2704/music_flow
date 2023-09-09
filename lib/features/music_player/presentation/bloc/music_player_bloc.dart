import 'dart:isolate';

import 'package:audio_picker/audio_picker.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'music_player_event.dart';
part 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  MusicPlayerBloc()
      : super(const MusicPlayerInitial(
          tracks: [],
        )) {
    on<MusicInitialStateEvent>((event, emit) => null);
    on<MusicFetchedSuccessEvent>(
      (event, emit) async {
        await _onMusicFetchedEvent(event, emit).then((value) => null);
      },
    );
  }

  Future<void> _onMusicFetchedEvent(event, emit) async {
    final receivePort = ReceivePort();
    BackgroundIsolateBinaryMessenger.ensureInitialized(
        ServicesBinding.rootIsolateToken!);

    await Isolate.spawn(AudioQueryService.pickMp3File,
        [receivePort.sendPort, ServicesBinding.rootIsolateToken!]);

    await for (final message in receivePort) {
      if (!emit.isDone) {
        emit(MusicPlayerSuccessState(tracks: message));
      }
    }
  }

  Future<void> _onMusicInitialEvent(event, emit) async {}
}
