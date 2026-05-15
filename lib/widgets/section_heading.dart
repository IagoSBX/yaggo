import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeading extends StatelessWidget {
  final String label;
  final String title;

  const SectionHeading({
    super.key,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppText.body(11, color: AppColors.yellow, letterSpacing: 2),
        ),
        const SizedBox(height: 4),
        Text(title, style: AppText.display(34)),
      ],
    );
  }
}
