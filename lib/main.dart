import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ShapesDemoApp());
}

class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes + Emoji Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ShapesDemoScreen(),
    );
  }
}

class ShapesDemoScreen extends StatefulWidget {
  const ShapesDemoScreen({super.key});
  @override
  State<ShapesDemoScreen> createState() => _ShapesDemoScreenState();
}

enum EmojiType { party, heart, smiley }

class _ShapesDemoScreenState extends State<ShapesDemoScreen> {
  EmojiType _selected = EmojiType.party;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shapes + Emoji Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Task 1 =====
            const Text('Task 1: Basic Shapes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: BasicShapesPainter(),
                size: const Size(double.infinity, 200),
              ),
            ),

            const SizedBox(height: 24),

            // ===== Task 2 =====
            const Text('Task 2: Big Bright Smiley',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 280,
              child: CustomPaint(
                painter: SmileyFace(),
                size: const Size(double.infinity, 280),
              ),
            ),

            const SizedBox(height: 24),

            // ===== Core: Interactive Emoji =====
            const Text('Interactive Emoji (Selection + Dynamic Drawing)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Choose emoji:'),
                const SizedBox(width: 12),
                DropdownButton<EmojiType>(
                  value: _selected,
                  items: const [
                    DropdownMenuItem(
                      value: EmojiType.party,
                      child: Text('Party Face 🎉'),
                    ),
                    DropdownMenuItem(
                      value: EmojiType.heart,
                      child: Text('Heart ❤️'),
                    ),
                    DropdownMenuItem(
                      value: EmojiType.smiley,
                      child: Text('Smiley 🙂'),
                    ),
                  ],
                  onChanged: (v) => setState(() => _selected = v ?? EmojiType.party),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 320,
              child: CustomPaint(
                painter: EmojiPainter(_selected),
                size: const Size(double.infinity, 320),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Task 1: Basic Shapes =====
class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final squareOffset = Offset(centerX - 80, centerY);
    final circleOffset = Offset(centerX, centerY);
    final arcOffset = Offset(centerX + 80, centerY);
    final rectOffset = Offset(centerX - 160, centerY);
    final lineStart = Offset(centerX - 200, centerY - 50);
    final lineEnd = Offset(centerX - 140, centerY + 50);
    final ovalOffset = Offset(centerX + 160, centerY);

    // Square
    final squarePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: squareOffset, width: 60, height: 60),
      squarePaint,
    );

    // Circle
    final circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(circleOffset, 30, circlePaint);

    // Arc
    final arcPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Rect.fromCenter(center: arcOffset, width: 60, height: 60),
      0,
      2.1,
      false,
      arcPaint,
    );

    // Rectangle
    final rectPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: rectOffset, width: 80, height: 40),
      rectPaint,
    );

    // (Still shows a line to compare—but Task 1 focuses on shapes)
    final linePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3;
    canvas.drawLine(lineStart, lineEnd, linePaint);

    // Oval
    final ovalPaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: ovalOffset, width: 80, height: 40),
      ovalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ===== Task 2: Big Bright Smiley =====
class SmileyFace extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = min(size.width, size.height) * 0.35;

    // Face
    final face = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    final border = Paint()
      ..color = Colors.orange.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, r, face);
    canvas.drawCircle(center, r, border);

    // Eyes
    final eyeWhite = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final eyeBorder = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final iris = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final eyeOffsetX = r * 0.45;
    final eyeOffsetY = r * -0.2;
    final eyeRadius = r * 0.16;
    final pupilRadius = eyeRadius * 0.4;

    final leftEyeCenter = center.translate(-eyeOffsetX, eyeOffsetY);
    final rightEyeCenter = center.translate(eyeOffsetX, eyeOffsetY);

    for (final c in [leftEyeCenter, rightEyeCenter]) {
      canvas.drawCircle(c, eyeRadius, eyeWhite);
      canvas.drawCircle(c, eyeRadius, eyeBorder);
      canvas.drawCircle(c.translate(0, 2), pupilRadius, iris);
    }

    // Smile arc
    final mouthRect = Rect.fromCenter(
      center: center.translate(0, r * 0.25),
      width: r * 1.5,
      height: r * 1.2,
    );
    final smile = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(mouthRect, pi * 0.1, pi * 0.8, false, smile);

    // Custom blush
    final blush = Paint()
      ..color = Colors.pink.withOpacity(0.35)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(leftEyeCenter.translate(0, r * 0.25), eyeRadius * 0.7, blush);
    canvas.drawCircle(rightEyeCenter.translate(0, r * 0.25), eyeRadius * 0.7, blush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ===== Core: Interactive Emoji Painter =====
class EmojiPainter extends CustomPainter {
  final EmojiType selected;
  EmojiPainter(this.selected);

  @override
  void paint(Canvas canvas, Size size) {
    switch (selected) {
      case EmojiType.party:
        _drawPartyFace(canvas, size);
        break;
      case EmojiType.heart:
        _drawHeart(canvas, size);
        break;
      case EmojiType.smiley:
        _drawSimpleSmiley(canvas, size);
        break;
    }
  }

  // Party Face with hat + confetti
  void _drawPartyFace(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = min(size.width, size.height) * 0.28;

    // Face
    canvas.drawCircle(center, r, Paint()..color = Colors.yellow);
    canvas.drawCircle(
        center, r, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 5);

    // Smiling eyes (arcs)
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;
    final eyeDX = r * 0.5;
    final eyeY = center.dy - r * 0.15;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(center.dx - eyeDX, eyeY), width: r * 0.6, height: r * 0.6),
      pi * 0.15,
      pi * 0.7,
      false,
      eyePaint,
    );
    canvas.drawArc(
      Rect.fromCenter(center: Offset(center.dx + eyeDX, eyeY), width: r * 0.6, height: r * 0.6),
      pi * 0.15,
      pi * 0.7,
      false,
      eyePaint,
    );

    // Big smile
    final mouthRect =
        Rect.fromCenter(center: center.translate(0, r * 0.3), width: r * 1.6, height: r * 1.2);
    canvas.drawArc(mouthRect, pi * 0.05, pi * 0.9, false, eyePaint);

    // Party hat (triangle)
    final hat = Path()
      ..moveTo(center.dx, center.dy - r * 1.25)
      ..lineTo(center.dx - r * 0.6, center.dy - r * 0.2)
      ..lineTo(center.dx + r * 0.6, center.dy - r * 0.2)
      ..close();
    canvas.drawPath(hat, Paint()..color = const Color(0xFF5C6BC0));
    canvas.drawPath(
      hat,
      Paint()
        ..color = Colors.black54
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Confetti (simple shapes/colors)
    final rng = Random(42);
    final confettiColors = [
      Colors.redAccent,
      Colors.lightGreen,
      Colors.amber,
      Colors.deepPurpleAccent,
      Colors.cyan,
    ];
    for (int i = 0; i < 24; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final dist = r * (1.1 + rng.nextDouble() * 0.6);
      final p = center + Offset(cos(angle), sin(angle)) * dist;
      final c = confettiColors[i % confettiColors.length];
      final t = i % 3;
      if (t == 0) {
        canvas.drawCircle(p, 4, Paint()..color = c);
      } else if (t == 1) {
        canvas.drawRect(Rect.fromCenter(center: p, width: 8, height: 8), Paint()..color = c);
      } else {
        canvas.drawLine(p, p + const Offset(8, -6), Paint()..color = c..strokeWidth = 3);
      }
    }
  }

  void _drawHeart(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final s = min(size.width, size.height) * 0.35;

    final path = Path();
    path.moveTo(center.dx, center.dy + s * 0.4);
    path.cubicTo(
      center.dx + s, center.dy + s * 0.05,
      center.dx + s * 0.8, center.dy - s * 0.8,
      center.dx, center.dy - s * 0.3,
    );
    path.cubicTo(
      center.dx - s * 0.8, center.dy - s * 0.8,
      center.dx - s, center.dy + s * 0.05,
      center.dx, center.dy + s * 0.4,
    );

    canvas.drawPath(path, Paint()..color = const Color(0xFFFF5252));
    canvas.drawPath(
        path, Paint()..color = Colors.black87..style = PaintingStyle.stroke..strokeWidth = 4);
  }

  void _drawSimpleSmiley(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = min(size.width, size.height) * 0.3;

    canvas.drawCircle(center, r, Paint()..color = Colors.yellow);
    canvas.drawCircle(
        center, r, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 5);

    // eyes
    final eye = Paint()..color = Colors.black;
    final dx = r * 0.45;
    canvas.drawCircle(center.translate(-dx, -r * 0.15), r * 0.12, eye);
    canvas.drawCircle(center.translate(dx, -r * 0.15), r * 0.12, eye);

    // smile
    final mouthRect =
        Rect.fromCenter(center: center.translate(0, r * 0.25), width: r * 1.4, height: r * 1.0);
    final mouth = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(mouthRect, pi * 0.1, pi * 0.8, false, mouth);
  }

  @override
  bool shouldRepaint(covariant EmojiPainter oldDelegate) => oldDelegate.selected != selected;
}
