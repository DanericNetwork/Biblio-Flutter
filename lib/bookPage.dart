import 'package:biblio_app/bottomAppBar.dart';
import 'package:flutter/material.dart';

// Create a new screen
class bookPage extends StatelessWidget {
  const bookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harry en de Steen der Wijzen', style: TextStyle(color: Colors.grey[300])),
        backgroundColor: const Color.fromRGBO(30,36,56, 1),
        iconTheme: IconThemeData(color: Colors.grey[300]),
      ),
      body: const Center(
        child: Text(
          'Noice',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}