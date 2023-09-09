part of 'music_player_bloc.dart';

abstract class MusicPlayerState extends Equatable {
  final List<Track> tracks;
  final Track? currentTrack;
  const MusicPlayerState({required this.tracks, this.currentTrack});

  @override
  List<Object> get props => [];
}

class MusicPlayerInitial extends MusicPlayerState {
  const MusicPlayerInitial({required super.tracks, super.currentTrack});
}

class MusicPlayerSuccessState extends MusicPlayerState {
  const MusicPlayerSuccessState({required super.tracks});
}

class MusicPlayerLoadingState extends MusicPlayerState {
  const MusicPlayerLoadingState({required super.tracks, required super.currentTrack});
}
