import 'package:dw/screens/Themes/ThemesScreen/themes_screen.dart';
import 'package:dw/screens/not_found_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // final args = settings.arguments;
        switch(settings.name){
          case'/':return MaterialPageRoute(builder:(_) => const ThemeScreen());
          // case 'theme' : 
            // final dynamic id = args['id'];
          //  return MaterialPageRoute(builder:(_) => id!=null? ThemeDetailScreen(id:id):const Four04Page("вывы") );
          default : return MaterialPageRoute(builder: (_) => const Four04Page("ds")); 
        }
      },
    ),
  );
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: InkWell(
          // Within the `FirstScreen` widget
          onTap: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
          child: const Text('Launch screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}