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

  if (cameras.isNotEmpty) {
    CameraDescription firstCamera = cameras.first;
    // Now you can use the 'firstCamera' object as needed
    print('There are ${cameras.length} cameras available');
  } else {
    print('No cameras available');
  }

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CameraDescription> camera = widget.cameras;
    print('Build stukkie ${camera}');
    // CameraDescription camera = widget.cameras.first;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: const Color.fromRGBO(30, 36, 56, 1),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: TextStyle(color: Colors.grey[300])),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
                  Icons.home_outlined), // replace with your desired icon
              color: Colors.grey[300],
              style: ButtonStyle(
                // this backgroundColor makes it usable on any background color, here set to transparent
                iconSize: MaterialStateProperty.all(40.0),
              ),
              onPressed: () {
                // Show the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewPage()),
                );
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
                // Show the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TakePictureScreen(
                    // Use the default camera
                    // camera: camera.first,
                    camera: CameraDescription(
                      name: '0',
                      lensDirection: CameraLensDirection.back,
                      sensorOrientation: 90,
                    ),
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

// // Create the camera screen
// class NewPage extends StatelessWidget {
//   const NewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Camera'),
//       ),
//       body: const Center(
//         child: Text(
//           'Camera',
//           style: TextStyle(
//             fontSize: 30.0,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }