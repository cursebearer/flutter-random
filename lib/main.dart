import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const TimerApp());
}

class TimerApp extends StatelessWidget {

  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  late Timer timer;
  int seconds = 0;
  bool isRunning = false;

  void startTimer() {
    if (!isRunning) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          seconds++;
        });
      });
      setState(() {
        isRunning = true;
      });
    }
  }

  void pauseTimer() {
    if (isRunning) {
      timer.cancel();
      setState(() {
        isRunning = false;
      });
    }
  }

  void resetTimer() {
    timer.cancel();
    setState(() {
      seconds = 0;
      isRunning = false;
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Cronômetro Simples'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatTime(seconds),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startTimer,
                  child: const Text('Iniciar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: pauseTimer,
                  child: const Text('Pausar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text('Resetar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
