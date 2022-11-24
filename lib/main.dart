
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContainerR()
    );
  }
}

class ContainerR extends StatelessWidget {
  const ContainerR({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SHATHA")),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Container(
              color: Colors.grey,
              height: 100,
              width: 100,
            ),
            Container(
              color: Colors.grey,
              height: 100,
              width: 100,
            ),
          ],),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Container(
              color: Colors.grey,
              height: 100,
              width: 100,
            ),
            Container(
              color: Colors.grey,
              height: 100,
              width: 100,
            ),
          ],),
        ],
      ),
    );
  }
}