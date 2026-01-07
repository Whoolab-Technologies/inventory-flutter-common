import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringX on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  Color toColor() {
    String hex = replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Add FF for full opacity
    }
    return Color(int.parse(hex, radix: 16));
  }

  MaterialColor toMaterialColor() {
    String hex = replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Add FF for full opacity
    }
    Color color = Color(int.parse(hex, radix: 16));
    List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  String toUpperCaseWithSpace() {
    return toUpperCase().replaceAll('_', ' ');
  }
}

extension FileX on FileSystemEntity {
  String get name {
    return path.split("/").last;
  }

  String get ext {
    return path.split(".").last;
  }
}

extension DateTimeX on DateTime {
  String toDateString({String format = 'MM-dd-yyyy'}) {
    final dateFormatter = DateFormat(format);
    return dateFormatter.format(this);
  }
}

extension TimeOfDayX on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    int newHour = this.hour + hour;
    int newMinute = this.minute + minute;

    // Handle minute overflow
    if (newMinute >= 60) {
      newHour += newMinute ~/ 60;
      newMinute %= 60;
    }

    newHour %= 24;

    return replacing(hour: newHour, minute: newMinute);
  }

  String toFormattedString() {
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }
}
