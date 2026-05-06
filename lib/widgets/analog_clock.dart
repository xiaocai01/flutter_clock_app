import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class AnalogClock extends StatefulWidget {
  const AnalogClock({Key? key}) : super(key: key);

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  late Timer _timer;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClockPainter(_dateTime),
      size: const Size.square(300),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = size.width / 2;

    // 绘制外圆圈
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.grey.shade200
        ..style = PaintingStyle.fill,
    );

    // 绘制边框
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.grey.shade800
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // 绘制时钟刻度
    _drawClockMarks(canvas, center, radius);

    // 计算角度
    final seconds = dateTime.second;
    final minutes = dateTime.minute;
    final hours = dateTime.hour % 12;

    final secondAngle = (seconds * 6.0) * math.pi / 180;
    final minuteAngle = ((minutes + seconds / 60) * 6.0) * math.pi / 180;
    final hourAngle =
        ((hours + minutes / 60 + seconds / 3600) * 30.0) * math.pi / 180;

    // 绘制指针
    _drawHand(canvas, center, hourAngle, radius * 0.4, 6, Colors.grey.shade800);
    _drawHand(canvas, center, minuteAngle, radius * 0.55, 4, Colors.grey.shade700);
    _drawHand(canvas, center, secondAngle, radius * 0.6, 2, Colors.red);

    // 绘制中心点
    canvas.drawCircle(
      center,
      8,
      Paint()
        ..color = Colors.grey.shade800
        ..style = PaintingStyle.fill,
    );
  }

  void _drawHand(
    Canvas canvas,
    Offset center,
    double angle,
    double length,
    double width,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    final endX = center.dx + length * math.sin(angle);
    final endY = center.dy - length * math.cos(angle);

    canvas.drawLine(
      center,
      Offset(endX, endY),
      paint,
    );
  }

  void _drawClockMarks(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = 2;

    for (int i = 0; i < 60; i++) {
      final angle = (i * 6.0) * math.pi / 180;
      final isHour = i % 5 == 0;
      final startRadius = isHour ? radius * 0.8 : radius * 0.85;
      final endRadius = radius * 0.9;

      final startX = center.dx + startRadius * math.sin(angle);
      final startY = center.dy - startRadius * math.cos(angle);
      final endX = center.dx + endRadius * math.sin(angle);
      final endY = center.dy - endRadius * math.cos(angle);

      if (isHour) {
        paint.strokeWidth = 3;
      } else {
        paint.strokeWidth = 1.5;
      }

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );

      // 绘制数字
      if (i % 5 == 0) {
        final number = i ~/ 5;
        final hour = number == 0 ? 12 : number;
        _drawNumber(
          canvas,
          center,
          hour,
          angle,
          radius * 0.7,
        );
      }
    }
  }

  void _drawNumber(
    Canvas canvas,
    Offset center,
    int number,
    double angle,
    double radius,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: number.toString(),
        style: const TextStyle(
          color: Color.fromARGB(255, 51, 51, 51),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final x = center.dx + radius * math.sin(angle) - textPainter.width / 2;
    final y = center.dy - radius * math.cos(angle) - textPainter.height / 2;

    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return oldDelegate.dateTime.second != dateTime.second;
  }
}
