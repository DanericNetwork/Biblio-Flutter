import 'package:biblio_app/main.dart';
import 'package:flutter/material.dart';
import 'bookPage.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromRGBO(30,36,56, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home_outlined), // replace with your desired icon
            color: Colors.grey[300],
            style: ButtonStyle(
              // this backgroundColor makes it usable on any background color, here set to transparent
              iconSize: MaterialStateProperty.all(40.0),
            ),
            onPressed: () {
              // handle your button tap here
            //   go to home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Biblio')),
            );
            },
          ),
          Expanded(
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0), // this makes the corners rounded
              ),
              child: const Center(
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
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_2), // replace with your desired icon
            color: Colors.grey[300],
            style: ButtonStyle(
              // this backgroundColor makes it usable on any background color, here set to transparent
              iconSize: MaterialStateProperty.all(40.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const bookPage()),
              );
              // handle your button tap here
            },
          ),
        ],
      ),
    );
  }
}