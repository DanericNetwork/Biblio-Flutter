import 'package:biblio_app/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'barcodeScanner.dart';

import 'package:biblio_app/main.dart';  // Add this line

class CustomBottomAppBar extends StatelessWidget {

  final BarcodeScanner barcodeScanner = BarcodeScanner();

  CustomBottomAppBar({
    Key? key,
    required this.cameras,
    required this.reloadBooks,
  }) : super(key: key);

  final List<CameraDescription> cameras;

  String _scanBarcode = '';

  TextEditingController txt = TextEditingController();
  final Function reloadBooks;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromRGBO(30,36,56, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home_outlined),
            color: Colors.grey[300],
            style: ButtonStyle(
              iconSize: MaterialStateProperty.all(40.0),
            ),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          Expanded(
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0), // this makes the corners rounded
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Book',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  controller: txt,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.grey[300],
            style: ButtonStyle(
              iconSize: MaterialStateProperty.all(40.0),
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookForm(reloadBooks: reloadBooks)),
              );
            },
          ),
        ],
      ),
    );
  }
}