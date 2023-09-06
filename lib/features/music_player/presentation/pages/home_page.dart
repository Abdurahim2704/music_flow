import 'dart:isolate';
import 'dart:ui';

import 'package:audio_picker/audio_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/music_player_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    complexWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class MusicCart extends StatefulWidget {
  final Track track;
  final bool isSelected;
  const MusicCart({
    super.key,
    required this.track,
    required this.isSelected,
  });

  @override
  State<MusicCart> createState() => _MusicCartState();
}

class _MusicCartState extends State<MusicCart> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.withOpacity(0.16),
                        Colors.blue.withOpacity(0.05),
                      ])),
            ),
            ListTile(
              title: Text(
                widget.track.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: widget.isSelected ? Colors.yellow : Colors.black),
              ),
              subtitle: Text(
                widget.track.duration.durationFormatter,
                style: TextStyle(
                    color: widget.isSelected ? Colors.yellow : Colors.black),
              ),
              leading: SizedBox(
                height: 60,
                width: 60,
                child: widget.track.image != null
                    ? Image.memory(
                        widget.track.image!,
                      )
                    : Image.asset("assets/images/default.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension DurationToString on Duration {
  String get durationFormatter {
    String formattedDuration =
        '${(inMinutes % 60).toString().padLeft(2, '0')}:${(inSeconds % 60).toString().padLeft(2, '0')}';
    return formattedDuration;
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
