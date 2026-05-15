import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Hambúrguer desenhado via CustomPainter — fiel ao SVG do design original.
class BurgerIllustration extends StatelessWidget {
  final double size;

  const BurgerIllustration({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.black2,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.64, size * 0.54),
          painter: _BurgerPainter(),
        ),
      ),
    );
  }
}

class _BurgerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()..style = PaintingStyle.fill;

    void oval(double cx, double cy, double rw, double rh, Color c) {
      p.color = c;
      canvas.drawOval(
          Rect.fromCenter(center: Offset(cx, cy), width: rw, height: rh), p);
    }

    void rr(double x, double y, double w, double h, double r, Color c) {
      p.color = c;
      canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(r)),
          p);
    }

    oval(s.width * .5, s.height * .23, s.width * .73, s.height * .40, AppColors.bunTop);
    oval(s.width * .5, s.height * .17, s.width * .51, s.height * .22, AppColors.bunGloss);
    rr(s.width * .13, s.height * .40, s.width * .75, s.height * .10, 4, AppColors.cheese);
    rr(s.width * .09, s.height * .51, s.width * .82, s.height * .08, 3.5, AppColors.lettuce);
    rr(s.width * .13, s.height * .60, s.width * .75, s.height * .11, 5, AppColors.patty);
    oval(s.width * .5, s.height * .78, s.width * .73, s.height * .27, AppColors.bunTop);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
