import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoryIconPainter extends StatelessWidget {
  final String categoryId;
  final double size;

  const CategoryIconPainter(this.categoryId, {super.key, this.size = 24});

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: Size(size, size),
        painter: _Painter(categoryId),
      );
}

class _Painter extends CustomPainter {
  final String id;
  _Painter(this.id);

  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()..style = PaintingStyle.fill;
    final w = s.width;
    final h = s.height;

    void oval(double cx, double cy, double rw, double rh, Color c) {
      p.color = c;
      canvas.drawOval(
          Rect.fromCenter(center: Offset(cx, cy), width: rw, height: rh), p);
    }

    void rr(double x, double y, double w2, double h2, double r, Color c) {
      p.color = c;
      canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w2, h2), Radius.circular(r)),
          p);
    }

    switch (id) {
      case 'burgers':
        oval(w / 2, h * .26, w * .75, h * .34, AppColors.yellow);
        rr(w * .13, h * .42, w * .74, h * .13, 2, const Color(0xFFE8A020));
        rr(w * .13, h * .56, w * .74, h * .13, 2, const Color(0xFF4A7C2A));
        oval(w / 2, h * .79, w * .75, h * .26, const Color(0xFFC8860A));

      case 'combos':
        p.color = AppColors.yellow.withAlpha(200);
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(w * .29, h * .33, w * .42, h * .46),
                const Radius.circular(4)),
            p);
        rr(w * .375, h * .25, w * .25, h * .12, 2, const Color(0xFFE8A020));

      case 'drinks':
        p.color = AppColors.yellow.withAlpha(128);
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(w * .33, h * .2, w * .34, h * .58),
                const Radius.circular(8)),
            p);
        rr(w * .37, h * .16, w * .18, h * .10, 2, const Color(0xFF888888));
        oval(w / 2, h * .75, w * .34, h * .09, AppColors.yellow.withAlpha(178));

      case 'desserts':
        final stroke = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = AppColors.yellow;
        final path = Path()
          ..moveTo(w * .17, h * .63)
          ..quadraticBezierTo(w * .17, h * .29, w / 2, h * .29)
          ..quadraticBezierTo(w * .83, h * .29, w * .83, h * .63);
        canvas.drawPath(path, stroke);
        p.color = AppColors.yellow.withAlpha(153);
        canvas.drawOval(
            Rect.fromCenter(
                center: Offset(w / 2, h * .63), width: w * .67, height: h * .42),
            p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
