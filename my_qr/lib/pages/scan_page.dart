import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan')
      ),
      body: Center(child: Text('scan')),
      floatingActionButton: FloatingActionButton(
         child: Icon(Icons.check),
        onPressed: () {}
      ),
    );
  }
}