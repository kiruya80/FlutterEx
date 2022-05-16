import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const OUTER_HTML =
      "encodeURIComponent(document.documentElement.outerHTML)";
  static const WEB_SCROLL_HEIGHT = "document.documentElement.scrollHeight;";

  static const seed = Color(0xFF4F7E3E);

  ///
  /// https://material-foundation.github.io/material-theme-builder/#/dynamic
  /// https://m3.material.io/styles/color/the-color-system/key-colors-tones
  /// https://colors.muz.li/
  ///
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF346B23),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFB4F39A),
    onPrimaryContainer: Color(0xFF012200),
    secondary: Color(0xFF54624D),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD7E7CB),
    onSecondaryContainer: Color(0xFF121F0D),
    tertiary: Color(0xFF386668),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBCEBED),
    onTertiaryContainer: Color(0xFF002022),
    error: Color(0xFFBA1B1B),
    errorContainer: Color(0xFFFFDAD4),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410001),
    background: Color(0xFFFDFDF6),
    onBackground: Color(0xFF1A1C18),
    surface: Color(0xFFFDFDF6),
    onSurface: Color(0xFF1A1C18),
    surfaceVariant: Color(0xFFDFE4D7),
    onSurfaceVariant: Color(0xFF43483F),
    outline: Color(0xFF73796D),
    onInverseSurface: Color(0xFFF1F1EA),
    inverseSurface: Color(0xFF2F312D),
    inversePrimary: Color(0xFF99D681),
    shadow: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF99D681),
    onPrimary: Color(0xFF043900),
    primaryContainer: Color(0xFF1B520B),
    onPrimaryContainer: Color(0xFFB4F39A),
    secondary: Color(0xFFBCCBB1),
    onSecondary: Color(0xFF273421),
    secondaryContainer: Color(0xFF3D4B36),
    onSecondaryContainer: Color(0xFFD7E7CB),
    tertiary: Color(0xFFA0CFD1),
    onTertiary: Color(0xFF003739),
    tertiaryContainer: Color(0xFF1E4E50),
    onTertiaryContainer: Color(0xFFBCEBED),
    error: Color(0xFFFFB4A9),
    errorContainer: Color(0xFF930006),
    onError: Color(0xFF680003),
    onErrorContainer: Color(0xFFFFDAD4),
    background: Color(0xFF1A1C18),
    onBackground: Color(0xFFE2E3DC),
    surface: Color(0xFF1A1C18),
    onSurface: Color(0xFFE2E3DC),
    surfaceVariant: Color(0xFF43483F),
    onSurfaceVariant: Color(0xFFC3C8BC),
    outline: Color(0xFF8D9287),
    onInverseSurface: Color(0xFF1A1C18),
    inverseSurface: Color(0xFFE2E3DC),
    inversePrimary: Color(0xFF346B23),
    shadow: Color(0xFF000000),
  );
}
