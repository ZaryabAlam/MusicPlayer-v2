
//--------------- Format milliseconds 42057 to "00:42"
String formatDurationMilliseconds(int milliseconds) {
  int totalSeconds = (milliseconds / 1000).floor();

  int hours = totalSeconds ~/ 3600;
  int remainingSecondsAfterHours = totalSeconds % 3600;
  int minutes = remainingSecondsAfterHours ~/ 60;
  int seconds = remainingSecondsAfterHours % 60;

  if (hours > 0) {
    // Format as "HH:MM:SS"
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  } else {
    // Format as "MM:SS"
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}