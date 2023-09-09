import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/music_player/presentation/bloc/music_player_bloc.dart';
import 'features/music_player/presentation/pages/pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider<MusicPlayerBloc>(
        create: (_) => MusicPlayerBloc()..add(MusicFetchedSuccessEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          home: const HomePage(),
        ),
      );
    });
  }
}
