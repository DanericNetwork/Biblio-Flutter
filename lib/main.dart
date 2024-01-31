import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// Import pages
import 'camera.dart';
import 'testingPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = await availableCameras();

  CameraDescription firstCamera = cameras.first;

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

  // This widget is the root of your application.
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
  @override
  Widget build(BuildContext context) {
    List<CameraDescription> camera = widget.cameras;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(30, 36, 56, 1),
        title: Text(widget.title, style: TextStyle(color: Colors.grey[300])),
      ),
      body: const Center(
        child: Text(
          'Zoek of scan een boek',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(30, 36, 56, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                  Icons.home_outlined),
              color: Colors.grey[300],
              style: ButtonStyle(
                iconSize: MaterialStateProperty.all(40.0),
              ),
              onPressed: () {
                // 
              },
            ),
            Expanded(
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                      10.0),
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
                  const Icon(Icons.qr_code_2),
              color: Colors.grey[300],
              style: ButtonStyle(
                iconSize: MaterialStateProperty.all(40.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => TakePictureScreen(
                    camera: camera.first,
                  )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}