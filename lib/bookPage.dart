import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'bottomAppBar.dart';

class bookPage extends StatefulWidget {
  const bookPage({
    super.key,
    required this.cameras
  });

  final List<CameraDescription> cameras;

  @override
  _bookPageState createState() => _bookPageState();
}

class _bookPageState extends State<bookPage> {
  bool isAvailable = false;

  @override
  void initState() {
    super.initState();
    getBookStatus();
  }

  Future<void> getBookStatus() async {
    final response = await http.get(Uri.parse('https://books.1tb.nl/book/4104480785092/status'));
    if (response.statusCode == 200) {
      setState(() {
        isAvailable = jsonDecode(response.body)['available'];
      });
    }
  }

  Future<void> toggleBookStatus() async {
    final response = await http.post(Uri.parse('https://books.1tb.nl/book/4104480785092/status/toggle'));
    if (response.statusCode == 200) {
      setState(() {
        isAvailable = jsonDecode(response.body)['available'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harry en de Steen der Wijzen', style: TextStyle(color: Colors.grey[300])),
        backgroundColor: const Color.fromRGBO(30,36,56, 1),
        iconTheme: IconThemeData(color: Colors.grey[300]),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AspectRatio(
                    aspectRatio: 1/1,
                    child: Image.network(
                      'https://marketplace.canva.com/EAFh7bSCs1U/1/0/1131w/canva-brown-aesthetic-minimalist-note-book-cover-page-a4-document-yhk3SDUOdz8.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child:
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[300],
                    backgroundColor: isAvailable ? const Color.fromRGBO(30,36,56, 1) : Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: toggleBookStatus,
                  child: Text(isAvailable ? 'Lenen' : 'Uitgeleend'),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(cameras: widget.cameras, reloadBooks: () {},)
    );
  }
}