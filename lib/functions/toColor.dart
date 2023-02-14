/*
 * Convert color to Hex
 * Source: https://bosctechlabs.com/use-hexadecimal-color-strings-flutter/
 * it will return a color widget
 */


import 'package:flutter/material.dart';

extension ColorExtension on String {
  toColor() {
    var hexStringColor  = this;
    final buffer        = StringBuffer();

    if (hexStringColor.length == 6 || hexStringColor.length == 7) {
      buffer.write('ff');
      buffer.write(hexStringColor.replaceFirst("#", ""));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }
}