import 'package:flutter/material.dart';
import 'package:flutter_clock_app/screens/clock_screen.dart';

void main() {
  runApp(const FlutterClockApp());
}

class FlutterClockApp extends StatelessWidget {
  const FlutterClockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const ClockScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
