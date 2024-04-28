import 'package:flutter/material.dart';

class Four04Page extends StatelessWidget {
  final String message;
  const Four04Page(this.message, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Page Not Found')),
        body: Center(child: Text(message)),
      );
}