import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(112, 195, 255, 1),
        Color.fromRGBO(75, 101, 255, 1)
      ],
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(80.0)),
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  });

  final String label;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final BorderRadius borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
        ),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: padding,
          child: Text(
            label,
            style: textStyle ??
                GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
