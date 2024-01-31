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
                    backgroundColor: const Color.fromRGBO(30,36,56, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    print('Lenen button pressed');
                  },
                  child: const Text('Lenen'),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}