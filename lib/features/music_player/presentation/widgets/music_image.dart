import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MusicImage extends StatelessWidget {
  final Uint8List? image;
  final double size;
  const MusicImage({super.key, required this.image, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: image != null
          ? Image.memory(
              image!,
            )
          : Image.asset("assets/images/default.png"),
    );
  }
}
