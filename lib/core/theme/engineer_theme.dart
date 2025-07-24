import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class MaterialTheme {
  static late TextTheme textTheme;
  static final MaterialTheme _instance = MaterialTheme._internal();

  MaterialTheme._internal();

  static void init(TextTheme theme) {
    textTheme = theme;
  }

  factory MaterialTheme() {
    return _instance;
  }

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0022b8),
      surfaceTint: Color(0xff2343fa),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0c34f0),
      onPrimaryContainer: Color(0xffbec5ff),
      secondary: Color(0xff4b57aa),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff99a5fe),
      onSecondaryContainer: Color(0xff2b3789),
      tertiary: Color(0xff690082),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8e00af),
      onTertiaryContainer: Color(0xfff4b1ff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff1a1b25),
      onSurfaceVariant: Color(0xff444656),
      outline: Color(0xff757688),
      outlineVariant: Color(0xffc5c5d9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f303a),
      inversePrimary: Color(0xffbcc3ff),
      primaryFixed: Color(0xffdfe0ff),
      onPrimaryFixed: Color(0xff000d60),
      primaryFixedDim: Color(0xffbcc3ff),
      onPrimaryFixedVariant: Color(0xff0029d3),
      secondaryFixed: Color(0xffdfe0ff),
      onSecondaryFixed: Color(0xff000d60),
      secondaryFixedDim: Color(0xffbcc3ff),
      onSecondaryFixedVariant: Color(0xff323f90),
      tertiaryFixed: Color(0xfffdd6ff),
      onTertiaryFixed: Color(0xff340042),
      tertiaryFixedDim: Color(0xfff4aeff),
      onTertiaryFixedVariant: Color(0xff790095),
      surfaceDim: Color(0xffdad9e7),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f2ff),
      surfaceContainer: Color(0xffeeecfb),
      surfaceContainerHigh: Color(0xffe8e7f5),
      surfaceContainerHighest: Color(0xffe2e1ef),
    );
  }

  static ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbcc3ff),
      surfaceTint: Color(0xffbcc3ff),
      onPrimary: Color(0xff001a97),
      primaryContainer: Color(0xff0c34f0),
      onPrimaryContainer: Color(0xffbec5ff),
      secondary: Color(0xffbcc3ff),
      onSecondary: Color(0xff192679),
      secondaryContainer: Color(0xff354193),
      onSecondaryContainer: Color(0xffaab3ff),
      tertiary: Color(0xfff4aeff),
      onTertiary: Color(0xff55006a),
      tertiaryContainer: Color(0xff8e00af),
      onTertiaryContainer: Color(0xfff4b1ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff12131c),
      onSurface: Color(0xffe2e1ef),
      onSurfaceVariant: Color(0xffc5c5d9),
      outline: Color(0xff8e8fa3),
      outlineVariant: Color(0xff444656),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e1ef),
      inversePrimary: Color(0xff2343fa),
      primaryFixed: Color(0xffdfe0ff),
      onPrimaryFixed: Color(0xff000d60),
      primaryFixedDim: Color(0xffbcc3ff),
      onPrimaryFixedVariant: Color(0xff0029d3),
      secondaryFixed: Color(0xffdfe0ff),
      onSecondaryFixed: Color(0xff000d60),
      secondaryFixedDim: Color(0xffbcc3ff),
      onSecondaryFixedVariant: Color(0xff323f90),
      tertiaryFixed: Color(0xfffdd6ff),
      onTertiaryFixed: Color(0xff340042),
      tertiaryFixedDim: Color(0xfff4aeff),
      onTertiaryFixedVariant: Color(0xff790095),
      surfaceDim: Color(0xff12131c),
      surfaceBright: Color(0xff383843),
      surfaceContainerLowest: Color(0xff0c0e17),
      surfaceContainerLow: Color(0xff1a1b25),
      surfaceContainer: Color(0xff1e1f29),
      surfaceContainerHigh: Color(0xff282934),
      surfaceContainerHighest: Color(0xff33343f),
    );
  }

  static ThemeData dark() {
    return theme(darkScheme());
  }

  static ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: colorScheme.surface,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(
            color: colorScheme.primary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: colorScheme.primary,
          labelStyle: TextStyle(color: colorScheme.primary),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary),
              borderRadius: BorderRadius.circular(12)),
          // Change the text size of the input value
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
          side: WidgetStateProperty.all(
            BorderSide(
              color: colorScheme.primary,
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            const Size(double.infinity, 52.0),
          ),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(colorScheme.primary),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            minimumSize: WidgetStateProperty.all(
              const Size(double.infinity, 52.0),
            ),
          ),
        ),
      );

  /// success
  static const success = ExtendedColor(
    seed: Color(0xff009754),
    value: Color(0xff009754),
    light: ColorFamily(
      color: Color(0xff2e6a44),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb1f1c1),
      onColorContainer: Color(0xff12512e),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff2e6a44),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb1f1c1),
      onColorContainer: Color(0xff12512e),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff2e6a44),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb1f1c1),
      onColorContainer: Color(0xff12512e),
    ),
    dark: ColorFamily(
      color: Color(0xff96d5a6),
      onColor: Color(0xff00391c),
      colorContainer: Color(0xff12512e),
      onColorContainer: Color(0xffb1f1c1),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff96d5a6),
      onColor: Color(0xff00391c),
      colorContainer: Color(0xff12512e),
      onColorContainer: Color(0xffb1f1c1),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff96d5a6),
      onColor: Color(0xff00391c),
      colorContainer: Color(0xff12512e),
      onColorContainer: Color(0xffb1f1c1),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        success,
      ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
