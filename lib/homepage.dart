import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(title: Text("hello")),
        ListTile(title: Text("hello")),
        ListTile(title: Text("hello")),
        ListTile(title: Text("hell")),
      ],
    );
  }
}
