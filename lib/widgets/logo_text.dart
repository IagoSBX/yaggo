import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class LogoText extends StatelessWidget {
  final double size;

  const LogoText({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YAG-GO',
      style: GoogleFonts.bebasNeue(
        fontSize: size,
        color: AppColors.yellow,
        letterSpacing: 3,
      ),
    );
  }
}
