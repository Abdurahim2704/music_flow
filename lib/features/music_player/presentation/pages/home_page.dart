import 'dart:isolate';

import 'package:audio_picker/audio_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/music_player_bloc.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (context, state) {
          final data = state.tracks;
          return ListView.builder(
            itemBuilder: (context, index) {
              final track = data[index];
              return MusicCart(
                track: track,
                isSelected: index == currentIndex,
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }
}

void complexWork() async {
  final receivePort = ReceivePort();
  BackgroundIsolateBinaryMessenger.ensureInitialized(
      ServicesBinding.rootIsolateToken!);
  await Isolate.spawn((message) {
    AudioQueryService.pickMp3File(message);
  }, [receivePort.sendPort, ServicesBinding.rootIsolateToken!]);

  receivePort.listen((message) {});
}
