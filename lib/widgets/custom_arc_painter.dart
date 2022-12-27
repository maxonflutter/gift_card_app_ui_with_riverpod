import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomArcLines extends StatelessWidget {
  const CustomArcLines({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const arcCount = 24;
    final Size size = MediaQuery.of(context).size;
    final diameter = size.width / arcCount;

    return SizedBox(
      width: size.width,
      child: Row(
        children: List.generate(arcCount, (_) => CustomArc(diameter: diameter)),
      ),
    );
  }
}

class CustomArc extends StatelessWidget {
  final double diameter;

  const CustomArc({
    Key? key,
    this.diameter = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcPainter(),
      size: Size(diameter, diameter),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
