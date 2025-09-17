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
      ar
