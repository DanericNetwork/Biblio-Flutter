import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: BookModal(
          bookTitle: 'Harry Potter',
          author: 'J.K. Rowling',
          
        ),
      ),
    ),
  ));
}

class BookModal extends StatelessWidget {
  final String bookTitle;
  final String author;

  const BookModal({
    Key? key,
    required this.bookTitle,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
    width: double.infinity, // This will make the container take the maximum width
    padding: const EdgeInsets.all(20.0), // Add some padding
      color: Colors.grey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(bookTitle, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        Text(author, style: const TextStyle(fontSize: 16.0)),
      ],
    ),
  );
}
}
