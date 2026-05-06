import 'package:flutter/material.dart';
import 'dart:async';

class TimezoneClock extends StatefulWidget {
  final String timezoneName;
  final String displayName;
  final String offset;

  const TimezoneClock({
    Key? key,
    required this.timezoneName,
    required this.displayName,
    required this.offset,
  }) : super(key: key);

  @override
  State<TimezoneClock> createState() => _TimezoneClockState();
}

class _TimezoneClockState extends State<TimezoneClock> {
  late Timer _timer;
  late String _timeString;
  late String _dateString;

  @override
  void initState() {
    super.initState();
    _timeString = '';
    _dateString = '';
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateTime();
    });
  }

  void _updateTime() {
    try {
      // 解析时区偏移量（例如：UTC+8, UTC-5）
      final offsetStr = widget.offset.replaceAll('UTC', '').trim();
      final offsetHours = int.parse(offsetStr);

      final now = DateTime.now().toUtc();
      final zonedTime = now.add(Duration(hours: offsetHours));

      setState(() {
        _timeString =
            '${zonedTime.hour.toString().padLeft(2, '0')}:${zonedTime.minute.toString().padLeft(2, '0')}:${zonedTime.second.toString().padLeft(2, '0')}';
        _dateString =
            '${zonedTime.year}-${zonedTime.month.toString().padLeft(2, '0')}-${zonedTime.day.toString().padLeft(2, '0')}';
      });
    } catch (e) {
      setState(() {
        _timeString = '--:--:--';
        _dateString = '----/--/--';
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  widget.offset,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _timeString,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _dateString,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
