import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';

final lightTheme = ThemeData(
  textTheme: textTheme,
  colorScheme: ColorScheme.fromSeed(seedColor: ColorLight.blueLight),
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  dialogTheme: DialogThemeData(
    backgroundColor: Colors.white,
    insetPadding: const EdgeInsets.symmetric(horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  ),
);
final textTheme = TextTheme(
  headlineLarge: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w900),
  headlineMedium: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w900),
  headlineSmall: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900),
  titleLarge: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w800),
  titleMedium: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800),
  titleSmall: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w800),
  bodyLarge: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700),
  bodyMedium: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700),
  bodySmall: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w700),
);
