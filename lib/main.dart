import 'package:flutter/material.dart';

void main() {
  runApp(const SmileyApp());
}

class SmileyApp extends StatelessWidget {
  const SmileyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smiley Face Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text("Task 4: Smiley Face")),
        body: Center(
          child: SizedBox(
            height: 300,
            width: 300,
            child: CustomPaint(
              painter: SmileyFace(),
            ),
          ),
        ),
      ),
    );
  }
}

class SmileyFace extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    //Head
    final headPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX - 7, centerY + 20), 120, headPaint);

    // Eyes
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final eyeBorder = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Right eye
    canvas.drawCircle(Offset(centerX + 40, centerY), 30, eyePaint);
    canvas.drawCircle(Offset(centerX + 40, centerY), 30, eyeBorder);

    // Left eye
    canvas.drawCircle(Offset(centerX - 50, centerY), 30, eyePaint);
    canvas.drawCircle(Offset(centerX - 50, centerY), 30, eyeBorder);

    // Pupils
    final pupilPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX + 40, centerY), 10, pupilPaint);
    canvas.drawCircle(Offset(centerX - 50, centerY), 10, pupilPaint);

    // Smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(
      Rect.fromCenter(center: Offset(centerX - 10, centerY + 50), width: 100, height: 70),
      0.6,
      2,
      false,
      smilePaint,
    );

    canvas.drawArc(
      Rect.fromCenter(center: Offset(centerX - 5, centerY + 69), width: 100, height: 30),
      0.6,
      -1.5,
      false,
      smilePaint,
    );


  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
