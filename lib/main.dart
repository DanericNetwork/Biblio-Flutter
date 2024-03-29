import 'dart:async';

import 'package:biblio_app/barcodeScanner.dart';
import 'package:biblio_app/bookPage.dart';
import 'package:biblio_app/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'bottomAppBar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = await availableCameras();

  runApp(MyApp(
    cameras: cameras,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.cameras,
  });

  List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblio App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Biblio',
        cameras: cameras,
      ),
      routes: {
        '/bookPage': (context) => bookPage(
              cameras: cameras,
            ),
        '/camera': (context) => TakePictureScreen(camera: cameras.first),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.cameras});

  List<CameraDescription> cameras;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  void loadBooks() async {
    books = await BookService.loadBooks();
    setState(() {});
  }

  void searchBooks(String search) async {
    books = await BookService.searchBooks(search);
    setState(() {});
  }

  void reloadBooks() {
    loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    List<CameraDescription> camera = widget.cameras;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromRGBO(30,36,56, 1)),
        backgroundColor:   const Color.fromRGBO(30,36,56, 1),
        title: Text(widget.title, style: TextStyle(color: Colors.grey[300])),
      ),
      body: ListView.builder(
        itemCount: books.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Book', style: TextStyle(fontSize: 20.0)),
                  Text('Available', style: TextStyle(fontSize: 20.0)),
                ],
              ),
            );
          }
          final book = books[index - 1];
          return Dismissible(
            key: Key(book.isbn),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              int bookIndex = books.indexWhere((b) => b.isbn == book.isbn);
              setState(() {
                books.removeAt(bookIndex);
              });
              await BookService.saveBooks(books);
            },
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.delete, color: Colors.white),
                    Text(" Delete", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            child: ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              leading: Image.network(book.image),
              trailing: IconButton(
                icon: Icon(
                  book.available
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: book.available ? Colors.green : Colors.red,
                ),
                onPressed: () async {
                  int bookIndex = books.indexWhere((b) => b.isbn == book.isbn);
                  setState(() {
                    books[bookIndex].available = !books[bookIndex].available;
                  });
                  await BookService.saveBooks(books);
                  print(jsonEncode(books.map((book) => book.toMap()).toList()));
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(cameras: camera, reloadBooks: reloadBooks, searchBooks: searchBooks),
    );
  }
}

class Book {
  final String title;
  final String image;
  final String isbn;
  final String author;
  bool available;

  Book(
      {required this.title,
      required this.image,
      required this.isbn,
      required this.author,
      this.available = true});

  // Convert a Book to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'isbn': isbn,
      'author': author,
      'available': available,
    };
  }

  // Convert a Map to a Book
  static Book fromMap(Map<String, dynamic> map) {
    return Book(
        title: map['title'],
        image: map['image'],
        isbn: map['isbn'],
        author: map['author'],
        available: map['available'] ?? true);
  }
}

class BookService {
  static Future<void> saveBooks(List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();
    final booksString = jsonEncode(books.map((book) => book.toMap()).toList());
    prefs.setString('books', booksString);
  }

  static Future<List<Book>> loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final booksString = prefs.getString('books') ?? '[]';
    final booksList = jsonDecode(booksString) as List;
    return booksList.map((bookMap) => Book.fromMap(bookMap)).toList();
  }

  static Future<List<Book>> searchBooks(String search) async {
    List<Book> books = await BookService.loadBooks();

    // search on title, description, author and isbn
    return books.where((book) =>
    book.title.toLowerCase().contains(search.toLowerCase()) ||
        book.author.toLowerCase().contains(search.toLowerCase()) ||
        book.isbn.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }
}

class BookForm extends StatefulWidget {
  final Function reloadBooks;

  BookForm({required this.reloadBooks});

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _imageController = TextEditingController();
  final _isbnController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Book'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _isbnController,
                    decoration: InputDecoration(
                      labelText: 'Barcode'
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an barcode';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.qr_code),
                  onPressed: () async {
                    BarcodeScanner scanner = BarcodeScanner();
                    await scanner.scanBarcodeNormal();
                    setState(() {
                      _isbnController.text = scanner.getBarcode();
                    }); 
                  },
                ),
              ],
            ),
            TextFormField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an author';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Book newBook = Book(
                    title: _titleController.text,
                    image: _imageController.text,
                    isbn: _isbnController.text,
                    author: _authorController.text,
                    available: true,
                  );
                  List<Book> books = await BookService.loadBooks();
                  books.add(newBook);
                  await BookService.saveBooks(books);
                  Navigator.pop(context);
                  widget.reloadBooks();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
