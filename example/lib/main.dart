import 'dart:math';
import 'package:custom_linear_progress/custom_linear_progress.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Linear Progress',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Linear Progress'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _percent = 100;
  Color _color = Colors.green;

  changeColor() {
    final random = Random();
    _percent = random.nextInt(100);
    setState(() {
      if (_percent >= 80) {
        _color = Colors.green;
      } else if (_percent >= 60 && _percent < 80) {
        _color = const Color.fromARGB(255, 239, 208, 81);
      } else if (_percent >= 40 && _percent < 60) {
        _color = Colors.orange;
      } else if (_percent >= 20 && _percent < 40) {
        _color = const Color.fromARGB(255, 247, 118, 6);
      } else {
        _color = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton.small(
          child: const Icon(Icons.change_circle),
          onPressed: () async {
            changeColor();
          }),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomProgressBar(
                percent: _percent,
                colorProgressGradient: _color,
                backgroundColor: Colors.grey.withOpacity(0.15),
                height: 30,
                // radius: 0,
                gradient: true,
                duration: 2000,
                animated: true,
              ),
            ),
            Text(_percent.toInt().toString() + '%'),
          ],
        ),
      ),
    );
  }
}
