import 'package:audio_picker/audio_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import 'glassmorphic_widget.dart';
import 'music_image.dart';

class MusicCart extends StatelessWidget {
  final Track track;
  final bool isSelected;
  const MusicCart({
    super.key,
    required this.track,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicWidget(
        height: 70,
        child: ListTile(
          title: Text(
            track.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: isSelected ? Colors.yellow : Colors.black),
          ),
          subtitle: Text(
            track.duration.durationFormatter,
            style: TextStyle(color: isSelected ? Colors.yellow : Colors.black),
          ),
          leading: MusicImage(
            image: track.image,
            size: 60,
          ),
        ));
  }
}
