class DateTimeHelper {
  static String formatMinutesString(int? totalMinutes) {
    if (totalMinutes == null) {
      return ''; // Return an empty string or a default value if null
    }

    int hours = totalMinutes ~/ 60; // Calculate full hours
    int minutes = totalMinutes % 60; // Remaining minutes

    String hoursPart =
        hours > 0 ? '${hours}h ' : ''; // Add hours part if hours > 0
    String minutesPart =
        minutes > 0 ? '${minutes}min' : ''; // Add minutes part if minutes > 0

    return '$hoursPart$minutesPart'
        .trim(); // Combine both parts and trim any extra spaces
  }
}
