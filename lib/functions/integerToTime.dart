/*
 * Convert number to time
 * Ex: 60 -> 1 min
 * docs https://dev.to/devlonoah/convert-integer-value-to-hour-minute-seconds-in-dart-48hc
 */

String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  String minuteLeft =
  m.toString().length < 2 ? "0" + m.toString() : m.toString();

  String secondsLeft =
  s.toString().length < 2 ? "0" + s.toString() : s.toString();

  String result = "$minuteLeft:$secondsLeft";

  return result;
}