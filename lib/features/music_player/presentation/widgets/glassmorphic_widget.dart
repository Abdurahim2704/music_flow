import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphicWidget extends StatelessWidget {
  final Widget child;
  final double height;
  const GlassmorphicWidget(
      {super.key, required this.child, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: height,
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
            child,
          ],
        ),
      ),
    );
  }
}
