import 'package:biblio_app/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();

  CustomBottomAppBar({
    Key? key,
    required this.cameras,
    required this.reloadBooks,
    required this.searchBooks,
  }) : super(key: key);

  final List<CameraDescription> cameras;
  final Function reloadBooks;
  final Function searchBooks;


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
            onPressed: () async {
              Navigator.of(context).popUntil((route) => route.isFirst);
              await searchBooks(_controller.text);
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
                  controller: _controller,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Book',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  onTap: () async => await searchBooks(_controller.text),
                  onSubmitted: (String value) async {
                    await searchBooks(value);
                  },
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_2),
            color: Colors.grey[300],
            style: ButtonStyle(
              iconSize: MaterialStateProperty.all(40.0),
            ),
            onPressed: () {
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
