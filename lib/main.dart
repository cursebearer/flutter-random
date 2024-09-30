import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const RandomNumberGeneratorApp());
}

class RandomNumberGeneratorApp extends StatelessWidget {

  const RandomNumberGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de Números Aleatórios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RandomNumberGeneratorScreen(),
    );
  }
}

class RandomNumberGeneratorScreen extends StatefulWidget {

  const RandomNumberGeneratorScreen({super.key});

  @override
  RandomNumberGeneratorScreenState createState() => RandomNumberGeneratorScreenState();
}

class RandomNumberGeneratorScreenState extends State<RandomNumberGeneratorScreen> {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  int? _randomNumber;

  void _generateRandomNumber() {
    final int? min = int.tryParse(_minController.text);
    final int? max = int.tryParse(_maxController.text);

    if (min != null && max != null && min < max) {
      setState(() {
        _randomNumber = min + Random().nextInt(max - min + 1);
      });
    } else {
      setState(() {
        _randomNumber = null; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Gerador de Números Aleatórios'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _minController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor Mínimo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _maxController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor Máximo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandomNumber,
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Gerar Número Aleatório',
              style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 40),
            if (_randomNumber != null)
              Text(
                'Número Gerado: $_randomNumber',
                style: const TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}