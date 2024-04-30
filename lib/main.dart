import 'package:dw/screens/Test/test_screen.dart';
import 'package:dw/screens/Themes/ThemesScreen/themes_screen.dart';
import 'package:dw/screens/not_found_screen.dart';
import 'package:flutter/material.dart';

import 'screens/ThemeDetail/ThemeDetail.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final Map args = (settings.arguments ?? {}) as Map;
        print(settings.name);
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const ThemeScreen());
          case '/theme':
            final int? id = args['id'];
            if (id == null) {
              return MaterialPageRoute(
                  builder: (_) => const Four04Page("id is null"));
            }
            return MaterialPageRoute(builder: (_) => ThemeDetailScreen(id));
          case '/test':
            final int id = args['id'];
            final int index = args['index'];
            return MaterialPageRoute(
                builder: (_) => TestScreen(themeId: id, index: index));

          default:
            return MaterialPageRoute(
                builder: (_) => const Four04Page("Такой страницы нет 😵‍💫"));
        }
      },
    ),
  );
}
