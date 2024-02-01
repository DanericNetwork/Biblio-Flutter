import 'package:flutter/material.dart';
import 'ItemCard.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Biblio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   bool isBookModalVisible = true;

  

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(30, 36, 56, 1),
        title: Text(widget.title, style: TextStyle(color: Colors.grey[300])),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text(
              'Zoek of scan een boek',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
          if (isBookModalVisible)
          const Positioned(
              top: 20, // Adjust the top value to your preference
              left: 0,
              right: 0,
              child: BookModal(
                bookTitle: 'Harry Potter',
                author: 'J.K. Rowling',
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(30, 36, 56, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                  Icons.home_outlined), // replace with your desired icon
              color: Colors.grey[300],
              style: ButtonStyle(
                // this backgroundColor makes it usable on any background color, here set to transparent
                iconSize: MaterialStateProperty.all(40.0),
              ),
              onPressed: () {
                // handle your button tap here
              },
            ),
            Expanded(
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                      10.0), // this makes the corners rounded
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
              icon:
                  const Icon(Icons.qr_code_2), // replace with your desired icon
              color: Colors.grey[300],
              style: ButtonStyle(
                // this backgroundColor makes it usable on any background color, here set to transparent
                iconSize: MaterialStateProperty.all(40.0),
              ),
              onPressed: () {
                // handle your button tap here
              },
            ),
          ],
        ),
      ),
    );
  }
}
