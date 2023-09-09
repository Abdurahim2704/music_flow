part of 'music_player_bloc.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();

  @override
  List<Object> get props => [];
}

class MusicFetchedSuccessEvent extends MusicPlayerEvent {}

class MusicInitialStateEvent extends MusicPlayerEvent {}