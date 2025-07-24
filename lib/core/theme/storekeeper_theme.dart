import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      primary: Color(0xff8d4c43),
      surfaceTint: Color(0xff8d4c43),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc87d72),
      onPrimaryContainer: Color(0xff4c1913),
      secondary: Color(0xff785651),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffdd0c9),
      onSecondaryContainer: Color(0xff795752),
      tertiary: Color(0xff6c5e18),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcab5d),
      onTertiaryContainer: Color(0xff4a3f00),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff211a19),
      onSurfaceVariant: Color(0xff534341),
      outline: Color(0xff867370),
      outlineVariant: Color(0xffd8c1be),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff362f2d),
      inversePrimary: Color(0xffffb4a9),
      primaryFixed: Color(0xffffdad5),
      onPrimaryFixed: Color(0xff390b07),
      primaryFixedDim: Color(0xffffb4a9),
      onPrimaryFixedVariant: Color(0xff70352d),
      secondaryFixed: Color(0xffffdad5),
      onSecondaryFixed: Color(0xff2d1511),
      secondaryFixedDim: Color(0xffe8bcb6),
      onSecondaryFixedVariant: Color(0xff5e3f3a),
      tertiaryFixed: Color(0xfff6e38e),
      onTertiaryFixed: Color(0xff211b00),
      tertiaryFixedDim: Color(0xffd9c775),
      onTertiaryFixedVariant: Color(0xff524600),
      surfaceDim: Color(0xffe4d7d5),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1ee),
      surfaceContainer: Color(0xfff9ebe9),
      surfaceContainerHigh: Color(0xfff3e5e3),
      surfaceContainerHighest: Color(0xffede0dd),
    );
  }

  static ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb4a9),
      surfaceTint: Color(0xffffb4a9),
      onPrimary: Color(0xff542019),
      primaryContainer: Color(0xffc87d72),
      onPrimaryContainer: Color(0xff4c1913),
      secondary: Color(0xffe8bcb6),
      onSecondary: Color(0xff452925),
      secondaryContainer: Color(0xff61413d),
      onSecondaryContainer: Color(0xffd9aea8),
      tertiary: Color(0xffd9c775),
      onTertiary: Color(0xff393000),
      tertiaryContainer: Color(0xffbcab5d),
      onTertiaryContainer: Color(0xff4a3f00),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff181211),
      onSurface: Color(0xffede0dd),
      onSurfaceVariant: Color(0xffd8c1be),
      outline: Color(0xffa08c89),
      outlineVariant: Color(0xff534341),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffede0dd),
      inversePrimary: Color(0xff8d4c43),
      primaryFixed: Color(0xffffdad5),
      onPrimaryFixed: Color(0xff390b07),
      primaryFixedDim: Color(0xffffb4a9),
      onPrimaryFixedVariant: Color(0xff70352d),
      secondaryFixed: Color(0xffffdad5),
      onSecondaryFixed: Color(0xff2d1511),
      secondaryFixedDim: Color(0xffe8bcb6),
      onSecondaryFixedVariant: Color(0xff5e3f3a),
      tertiaryFixed: Color(0xfff6e38e),
      onTertiaryFixed: Color(0xff211b00),
      tertiaryFixedDim: Color(0xffd9c775),
      onTertiaryFixedVariant: Color(0xff524600),
      surfaceDim: Color(0xff181211),
      surfaceBright: Color(0xff3f3736),
      surfaceContainerLowest: Color(0xff130d0c),
      surfaceContainerLow: Color(0xff211a19),
      surfaceContainer: Color(0xff251e1d),
      surfaceContainerHigh: Color(0xff302827),
      surfaceContainerHighest: Color(0xff3b3332),
    );
  }

  ThemeData dark() {
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
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(foregroundColor: Colors.white),
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
