extension DurationToString on Duration {
  String get durationFormatter {
    String formattedDuration =
        '${(inMinutes % 60).toString().padLeft(2, '0')}:${(inSeconds % 60).toString().padLeft(2, '0')}';
    return formattedDuration;
  }
}
