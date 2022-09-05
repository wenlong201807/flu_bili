import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true; // Remove to suppress visual layout
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: SafeArea(
        // Change to buildColumn() for the other column example
        // body: Center(child: buildRow()),
        // child: buildColumn(),
        child: startRow(),
        // child: buildRow(),
      ),
    );
  }

  Widget buildRow() =>
      // #docregion Row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Image.asset('images/android.png'),
          ),
          Expanded(
            flex: 2,
            child: Image.asset('images/android.png'),
          ),
          Expanded(
            child: Image.asset('images/android.png'),
          ),
          // Image.asset('images/android.png'),
          // Image.asset('images/android.png'),
          // Image.asset('images/android.png'),
        ],
      );
  // #enddocregion Row

  Widget buildColumn() =>
      // #docregion Column
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('images/android.png'),
          Image.asset('images/android.png'),
          Image.asset('images/android.png'),
        ],
      );
  // #enddocregion Column

  Widget startRow() =>
      // #docregion Column
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.green[500]),
          Icon(Icons.star, color: Colors.green[500]),
          Icon(Icons.star, color: Colors.green[500]),
          const Icon(Icons.star, color: Colors.black),
          const Icon(Icons.star, color: Colors.black),
        ],
      );
  // #enddocregion Column
}
