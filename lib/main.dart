import 'package:flutter/material.dart';

void main() {
  runApp(const SmileyApp());
}

class SmileyApp extends StatefulWidget {
  const SmileyApp({super.key});

  @override
  State<SmileyApp> createState() => _SmileyAppState();
}

class _SmileyAppState extends State<SmileyApp> {
  String _selectedEmoji = "smiley"; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji Drawer',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Choose Emoji"),
          backgroundColor: Colors.blueAccent,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Text(
                  "Emoji Options",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              // When you click on one of the options, it changes the state to "smiley" or "heart", when you add the party hat emoji, set status to smth like "party" and then make it change to that on tap
              // Then refer to comment below
              ListTile(
                title: const Text("Smiley Face"),
                onTap: () {
                  setState(() {
                    _selectedEmoji = "smiley";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Heart"),
                onTap: () {
                  setState(() {
                    _selectedEmoji = "heart";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: SizedBox(
            height: 300,
            width: 300,
            // When you want to add more emojis to the drawer, create a class i.e PartyPainter and then add it to the list below. It's like an if else sequence
            // Gonna have to change the code below, since we now have 3 or 4 emojis instead of just 2. In pseudo code it's like if "smiley", then painter = SmileyPainter, do that for each emoji.
            // Make a party hat emoji w/ confetti, I've made the heart and smiley face already.
            
            child: CustomPaint(
              painter: _selectedEmoji == "smiley"
                  ? SmileyPainter()
                  : HeartPainter(),
            ),
          ),
        ),
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
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
      Rect.fromCenter(
        center: Offset(centerX - 10, centerY + 50),
        width: 100,
        height: 70,
      ),
      0.6,
      2,
      false,
      smilePaint,
    );
    // cheeky lil dimple
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX - 10, centerY + 69),
        width: 100,
        height: 30,
      ),
      0.6,
      -1.5,
      false,
      smilePaint,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}

class HeartPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint();
      paint
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 6;

      Paint paint1 = Paint();
      paint1
        ..color = Colors.red
        ..style = PaintingStyle.fill
        ..strokeWidth = 0;

      double width = size.width;
      double height = size.height;

      Path path = Path();
      path.moveTo(0.5 * width, height * 0.35);
      path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
          0.5 * width, height);
      path.moveTo(0.5 * width, height * 0.35);
      path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
          0.5 * width, height);

      canvas.drawPath(path, paint1);
      canvas.drawPath(path, paint);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
    }

}

  