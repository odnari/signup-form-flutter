import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppColors {
  static const Color primaryColor = Color.fromRGBO(111, 145, 188, 1);
  static const Color secondaryColor = Color.fromRGBO(74, 78, 113, 1);
  static const Color errorColor = Color.fromRGBO(255, 128, 128, 1);
  static const Color successColor = Color.fromRGBO(39, 178, 116, 1);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ),
      primaryTextTheme: GoogleFonts.interTextTheme(
        ThemeData.light().primaryTextTheme,
      ),
      inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14.5),
            filled: true,
            fillColor: Colors.white,
            hintStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryColor,
            ),
            errorStyle: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.errorColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
              ),
            ),
          ),
    );
  }
}
