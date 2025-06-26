import 'package:flutter/material.dart';

class Appearance extends StatefulWidget {
  @override
  _AppearanceState createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appearance',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}