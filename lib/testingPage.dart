import 'package:flutter/material.dart';

// Create the camera screen
class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: const Center(
        child: Text(
          'Camera',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
