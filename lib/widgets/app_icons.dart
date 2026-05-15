import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ═════════════════════════════════════════════════════════════════════════════
//  AppIcons — SVG inline via CustomPainter
//  Substitui todos os Icons.* do Material que existiam no app.
// ═════════════════════════════════════════════════════════════════════════════

class AppIcon extends StatelessWidget {
  final _IconType type;
  final double size;
  final Color color;

  const AppIcon._(this.type, {super.key, this.size = 22, required this.color});

  // ── Construtores nomeados ─────────────────────────────────────────────────

  const AppIcon.home({super.key, this.size = 22, this.color = AppColors.gray})
      : type = _IconType.home;

  const AppIcon.homeOutlined({super.key, this.size = 22, this.color = AppColors.gray})
      : type = _IconType.homeOutlined;

  const AppIcon.menu({super.key, this.size = 22, this.color = AppColors.gray})
      : type = _IconType.menu;

  const AppIcon.menuOutlined({super.key, this.size = 22, this.color = AppColors.gray})
      : type = _IconType.menuOutlined;

  const AppIcon.bag({super.key, this.size = 22, this.color = AppColors.gray})
      : type = _IconType.bag;

  const AppIcon.bagOutlined({super.key, this.size = 22, this.color = AppColors.gray})
      : type = _IconType.bagOutlined;

  const AppIcon.receipt({super.key, this.size = 22, this.color = AppColors.gray})
      : type = _IconType.receipt;

  const AppIcon.receiptOutlined({super.key, this.size = 22, this.color = AppColors.gray})
      : type = _IconType.receiptOutlined;

  const AppIcon.back({super.key, this.size = 18, this.color = AppColors.yellow})
      : type = _IconType.back;

  const AppIcon.delete({super.key, this.size = 18, this.color = AppColors.gray})
      : type = _IconType.delete;

  const AppIcon.plus({super.key, this.size = 16, this.color = AppColors.yellow})
      : type = _IconType.plus;

  const AppIcon.minus({super.key, this.size = 16, this.color = AppColors.yellow})
      : type = _IconType.minus;

  const AppIcon.check({super.key, this.size = 14, this.color = AppColors.yellow})
      : type = _IconType.check;

  const AppIcon.checkCircle({super.key, this.size = 18, this.color = AppColors.yellow})
      : type = _IconType.checkCircle;

  const AppIcon.checkCircleLarge({super.key, this.size = 42, this.color = AppColors.yellow})
      : type = _IconType.checkCircleLarge;

  const AppIcon.dot({super.key, this.size = 6, this.color = AppColors.border})
      : type = _IconType.dot;

  const AppIcon.creditCard({super.key, this.size = 20, this.color = AppColors.gray})
      : type = _IconType.creditCard;

  const AppIcon.pix({super.key, this.size = 20, this.color = AppColors.gray})
      : type = _IconType.pix;

  const AppIcon.cash({super.key, this.size = 20, this.color = AppColors.gray})
      : type = _IconType.cash;

  const AppIcon.restaurant({super.key, this.size = 13, this.color = AppColors.yellow})
      : type = _IconType.restaurant;

  const AppIcon.delivery({super.key, this.size = 13, this.color = AppColors.info})
      : type = _IconType.delivery;

  const AppIcon.instagram({super.key, this.size = 15, this.color = AppColors.gray})
      : type = _IconType.instagram;

  const AppIcon.whatsapp({super.key, this.size = 15, this.color = AppColors.gray})
      : type = _IconType.whatsapp;

  const AppIcon.tiktok({super.key, this.size = 15, this.color = AppColors.gray})
      : type = _IconType.tiktok;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _IconPainter(type, color),
    );
  }
}

enum _IconType {
  home, homeOutlined,
  menu, menuOutlined,
  bag, bagOutlined,
  receipt, receiptOutlined,
  back, delete,
  plus, minus,
  check, checkCircle, checkCircleLarge, dot,
  creditCard, pix, cash,
  restaurant, delivery,
  instagram, whatsapp, tiktok,
}

class _IconPainter extends CustomPainter {
  final _IconType type;
  final Color color;
  _IconPainter(this.type, this.color);

  @override
  void paint(Canvas canvas, Size s) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = s.width * 0.09
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = s.width;
    final h = s.height;

    switch (type) {
      // ── Home (filled) ─────────────────────────────────────────────────────
      case _IconType.home:
        final path = Path()
          ..moveTo(w * .12, h * .52)
          ..lineTo(w * .5, h * .10)
          ..lineTo(w * .88, h * .52)
          ..lineTo(w * .78, h * .52)
          ..lineTo(w * .78, h * .90)
          ..lineTo(w * .58, h * .90)
          ..lineTo(w * .58, h * .65)
          ..lineTo(w * .42, h * .65)
          ..lineTo(w * .42, h * .90)
          ..lineTo(w * .22, h * .90)
          ..lineTo(w * .22, h * .52)
          ..close();
        canvas.drawPath(path, fill);

      // ── Home (outline) ────────────────────────────────────────────────────
      case _IconType.homeOutlined:
        final path = Path()
          ..moveTo(w * .12, h * .52)
          ..lineTo(w * .5, h * .10)
          ..lineTo(w * .88, h * .52)
          ..lineTo(w * .78, h * .52)
          ..lineTo(w * .78, h * .90)
          ..lineTo(w * .58, h * .90)
          ..lineTo(w * .58, h * .65)
          ..lineTo(w * .42, h * .65)
          ..lineTo(w * .42, h * .90)
          ..lineTo(w * .22, h * .90)
          ..lineTo(w * .22, h * .52)
          ..close();
        canvas.drawPath(path, stroke);

      // ── Menu / fork-knife (filled) ────────────────────────────────────────
      case _IconType.menu:
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.18, h*.10, w*.22, h*.55), Radius.circular(w*.05)), fill);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.60, h*.10, w*.22, h*.55), Radius.circular(w*.05)), fill);
        canvas.drawRect(Rect.fromLTWH(w*.22, h*.65, w*.14, h*.25), fill);
        canvas.drawRect(Rect.fromLTWH(w*.64, h*.65, w*.14, h*.25), fill);

      // ── Menu / fork-knife (outline) ───────────────────────────────────────
      case _IconType.menuOutlined:
        // fork left
        canvas.drawLine(Offset(w*.25, h*.12), Offset(w*.25, h*.88), stroke);
        canvas.drawLine(Offset(w*.18, h*.12), Offset(w*.18, h*.45), stroke);
        canvas.drawLine(Offset(w*.32, h*.12), Offset(w*.32, h*.45), stroke);
        // arc top fork
        final forkArc = Path()
          ..moveTo(w*.18, h*.45)
          ..quadraticBezierTo(w*.18, h*.56, w*.25, h*.56)
          ..quadraticBezierTo(w*.32, h*.56, w*.32, h*.45);
        canvas.drawPath(forkArc, stroke);
        // knife right
        canvas.drawLine(Offset(w*.68, h*.12), Offset(w*.68, h*.88), stroke);
        final knifeBlade = Path()
          ..moveTo(w*.68, h*.12)
          ..lineTo(w*.82, h*.38)
          ..quadraticBezierTo(w*.82, h*.50, w*.68, h*.50);
        canvas.drawPath(knifeBlade, stroke);

      // ── Shopping bag (filled) ─────────────────────────────────────────────
      case _IconType.bag:
        final body = Path()
          ..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.10, h*.32, w*.80, h*.60), Radius.circular(w*.10)));
        canvas.drawPath(body, fill);
        // handle (cutout white effect — draw stroke over)
        final handleStroke = Paint()
          ..color = AppColors.black2
          ..style = PaintingStyle.stroke
          ..strokeWidth = w * .10
          ..strokeCap = StrokeCap.round;
        final handle = Path()
          ..moveTo(w*.36, h*.32)
          ..cubicTo(w*.36, h*.14, w*.64, h*.14, w*.64, h*.32);
        canvas.drawPath(handle, handleStroke);

      // ── Shopping bag (outline) ────────────────────────────────────────────
      case _IconType.bagOutlined:
        final body = Path()
          ..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.10, h*.32, w*.80, h*.60), Radius.circular(w*.10)));
        canvas.drawPath(body, stroke);
        final handle = Path()
          ..moveTo(w*.36, h*.32)
          ..cubicTo(w*.36, h*.14, w*.64, h*.14, w*.64, h*.32);
        canvas.drawPath(handle, stroke);

      // ── Receipt (filled) ──────────────────────────────────────────────────
      case _IconType.receipt:
        final paper = Path()
          ..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.14, h*.08, w*.72, h*.84), Radius.circular(w*.05)));
        canvas.drawPath(paper, fill);
        // lines (cutout)
        final linePaint = Paint()
          ..color = AppColors.black2
          ..style = PaintingStyle.stroke
          ..strokeWidth = w * .07
          ..strokeCap = StrokeCap.round;
        for (final y in [h*.35, h*.50, h*.65]) {
          canvas.drawLine(Offset(w*.28, y), Offset(w*.72, y), linePaint);
        }

      // ── Receipt (outline) ─────────────────────────────────────────────────
      case _IconType.receiptOutlined:
        final paper = Path()
          ..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.14, h*.08, w*.72, h*.84), Radius.circular(w*.05)));
        canvas.drawPath(paper, stroke);
        for (final y in [h*.35, h*.50, h*.65]) {
          canvas.drawLine(Offset(w*.28, y), Offset(w*.72, y), stroke);
        }

      // ── Back arrow ────────────────────────────────────────────────────────
      case _IconType.back:
        final path = Path()
          ..moveTo(w*.62, h*.15)
          ..lineTo(w*.28, h*.50)
          ..lineTo(w*.62, h*.85);
        canvas.drawPath(path, stroke);

      // ── Delete / trash ────────────────────────────────────────────────────
      case _IconType.delete:
        // lid
        canvas.drawLine(Offset(w*.18, h*.30), Offset(w*.82, h*.30), stroke);
        canvas.drawLine(Offset(w*.38, h*.18), Offset(w*.62, h*.18), stroke);
        // body
        final body = Path()
          ..moveTo(w*.26, h*.30)
          ..lineTo(w*.32, h*.88)
          ..lineTo(w*.68, h*.88)
          ..lineTo(w*.74, h*.30);
        canvas.drawPath(body, stroke);
        // inner lines
        canvas.drawLine(Offset(w*.44, h*.42), Offset(w*.44, h*.76), stroke);
        canvas.drawLine(Offset(w*.56, h*.42), Offset(w*.56, h*.76), stroke);

      // ── Plus ─────────────────────────────────────────────────────────────
      case _IconType.plus:
        canvas.drawLine(Offset(w*.5, h*.15), Offset(w*.5, h*.85), stroke);
        canvas.drawLine(Offset(w*.15, h*.5), Offset(w*.85, h*.5), stroke);

      // ── Minus ────────────────────────────────────────────────────────────
      case _IconType.minus:
        canvas.drawLine(Offset(w*.15, h*.5), Offset(w*.85, h*.5), stroke);

      // ── Check mark ───────────────────────────────────────────────────────
      case _IconType.check:
        final path = Path()
          ..moveTo(w*.15, h*.50)
          ..lineTo(w*.42, h*.80)
          ..lineTo(w*.85, h*.20);
        canvas.drawPath(path, stroke);

      // ── Check circle (small) ─────────────────────────────────────────────
      case _IconType.checkCircle:
        canvas.drawCircle(Offset(w * .5, h * .5), w * .44, stroke);
        final check = Path()
          ..moveTo(w*.28, h*.50)
          ..lineTo(w*.44, h*.68)
          ..lineTo(w*.72, h*.32);
        canvas.drawPath(check, stroke);

      // ── Check circle (large, for confirmation screen) ────────────────────
      case _IconType.checkCircleLarge:
        canvas.drawCircle(Offset(w * .5, h * .5), w * .44,
            fill..color = AppColors.yellowDim);
        final check = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = w * .07
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
        final path = Path()
          ..moveTo(w*.28, h*.50)
          ..lineTo(w*.44, h*.68)
          ..lineTo(w*.72, h*.32);
        canvas.drawPath(path, check);

      // ── Dot (small circle) ───────────────────────────────────────────────
      case _IconType.dot:
        canvas.drawCircle(Offset(w * .5, h * .5), w * .4, fill);

      // ── Credit card ───────────────────────────────────────────────────────
      case _IconType.creditCard:
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.08, h*.20, w*.84, h*.60), Radius.circular(w*.08)), stroke);
        canvas.drawLine(Offset(w*.08, h*.42), Offset(w*.92, h*.42), stroke);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.18, h*.54, w*.22, h*.12), Radius.circular(w*.02)), fill);

      // ── Pix (lightning bolt) ──────────────────────────────────────────────
      case _IconType.pix:
        final path = Path()
          ..moveTo(w*.58, h*.10)
          ..lineTo(w*.32, h*.50)
          ..lineTo(w*.52, h*.50)
          ..lineTo(w*.26, h*.90)
          ..lineTo(w*.68, h*.46)
          ..lineTo(w*.46, h*.46)
          ..close();
        canvas.drawPath(path, fill);

      // ── Cash / money ──────────────────────────────────────────────────────
      case _IconType.cash:
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.08, h*.25, w*.84, h*.50), Radius.circular(w*.06)), stroke);
        canvas.drawCircle(Offset(w*.5, h*.50), w*.14, stroke);
        canvas.drawLine(Offset(w*.24, h*.38), Offset(w*.24, h*.62), stroke);
        canvas.drawLine(Offset(w*.76, h*.38), Offset(w*.76, h*.62), stroke);

      // ── Restaurant (fork + plate) ─────────────────────────────────────────
      case _IconType.restaurant:
        canvas.drawCircle(Offset(w*.5, h*.5), w*.38, stroke);
        canvas.drawLine(Offset(w*.5, h*.22), Offset(w*.5, h*.78), stroke);
        canvas.drawLine(Offset(w*.32, h*.22), Offset(w*.32, h*.50), stroke);
        canvas.drawLine(Offset(w*.68, h*.22), Offset(w*.68, h*.50), stroke);
        final arc = Path()
          ..moveTo(w*.32, h*.50)
          ..quadraticBezierTo(w*.32, h*.62, w*.50, h*.62)
          ..quadraticBezierTo(w*.68, h*.62, w*.68, h*.50);
        canvas.drawPath(arc, stroke);

      // ── Delivery (scooter simplified) ─────────────────────────────────────
      case _IconType.delivery:
        // body
        final body = Path()
          ..moveTo(w*.18, h*.60)
          ..lineTo(w*.30, h*.35)
          ..lineTo(w*.60, h*.35)
          ..lineTo(w*.78, h*.60);
        canvas.drawPath(body, stroke);
        // box on back
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.38, h*.22, w*.28, h*.22), Radius.circular(w*.04)), stroke);
        // wheels
        canvas.drawCircle(Offset(w*.24, h*.72), w*.12, stroke);
        canvas.drawCircle(Offset(w*.74, h*.72), w*.12, stroke);
        // handlebar
        canvas.drawLine(Offset(w*.60, h*.35), Offset(w*.70, h*.28), stroke);
        canvas.drawLine(Offset(w*.65, h*.28), Offset(w*.80, h*.28), stroke);

      // ── Instagram ─────────────────────────────────────────────────────────
      case _IconType.instagram:
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.10, h*.10, w*.80, h*.80), Radius.circular(w*.22)), stroke);
        canvas.drawCircle(Offset(w*.5, h*.5), w*.22, stroke);
        canvas.drawCircle(Offset(w*.73, h*.27), w*.06, fill);

      // ── WhatsApp (speech bubble with phone) ───────────────────────────────
      case _IconType.whatsapp:
        final bubble = Path()
          ..addOval(Rect.fromCenter(center: Offset(w*.5, h*.46), width: w*.78, height: h*.72));
        canvas.drawPath(bubble, stroke);
        // tail
        final tail = Path()
          ..moveTo(w*.28, h*.78)
          ..lineTo(w*.14, h*.92)
          ..lineTo(w*.42, h*.82);
        canvas.drawPath(tail, stroke);
        // phone icon inside
        canvas.drawLine(Offset(w*.36, h*.38), Offset(w*.44, h*.30), stroke..strokeWidth = w*.07);
        canvas.drawLine(Offset(w*.56, h*.56), Offset(w*.64, h*.48), stroke);
        final phone = Path()
          ..moveTo(w*.36, h*.38)
          ..cubicTo(w*.42, h*.32, w*.58, h*.50, w*.64, h*.56);
        stroke.strokeWidth = w * .09;
        canvas.drawPath(phone, stroke);

      // ── TikTok (musical note) ─────────────────────────────────────────────
      case _IconType.tiktok:
        // note stem
        canvas.drawLine(Offset(w*.56, h*.15), Offset(w*.56, h*.72), stroke..strokeWidth = w*.09);
        // flag
        final flag = Path()
          ..moveTo(w*.56, h*.15)
          ..cubicTo(w*.56, h*.15, w*.82, h*.10, w*.82, h*.38)
          ..cubicTo(w*.82, h*.38, w*.68, h*.34, w*.56, h*.38);
        canvas.drawPath(flag, stroke..strokeWidth = w*.09);
        // note head
        canvas.drawOval(Rect.fromCenter(center: Offset(w*.44, h*.72), width: w*.28, height: h*.20), fill);
    }
  }

  @override
  bool shouldRepaint(covariant _IconPainter old) =>
      old.type != type || old.color != color;
}
