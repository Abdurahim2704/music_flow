part of 'music_player_bloc.dart';

abstract class MusicPlayerState extends Equatable {
  final List<Track> tracks;
  const MusicPlayerState({required this.tracks});

  @override
  List<Object> get props => [];
}

class MusicPlayerInitial extends MusicPlayerState {
  const MusicPlayerInitial() : super(tracks: const []);
}

class MusicPlayerSuccessState extends MusicPlayerState {
  const MusicPlayerSuccessState({required super.tracks});
}

class MusicPlayerLoadingState extends MusicPlayerState {
  const MusicPlayerLoadingState({required super.tracks});
}
