import 'dart:convert';

import 'package:dw/entities/test/model/tests_repo.dart';
import 'package:dw/entities/test/ui/test_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../entities/test/model/dto/theme.dart';

class ThemePreview extends StatelessWidget {
  final String id;

  const ThemePreview({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
  TestsRepo repo = TestsRepo();
  repo.add(UserPartial(id: 1));
  print("ds");
  print(repo.items);
    return InkWell(
        onTap: () {
          print(id);
          Navigator.pushNamed(context, '/theme', arguments: {'id': id});
        },
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Theme Preview for ID: $id',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Image.asset('assets/preview/moneyGang.png')
          ],
        ));
  }
}

class ThemeScreen extends StatelessWidget {

  const ThemeScreen({super.key});

  Future<List<ThemeDTO>> _loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/db.json');
    List<ThemeDTO> themsDtos = [];
    List<dynamic> themes = json.decode(jsonString)['themes'];
    themes.forEach((element) {
      // List<DescriptionBlock> blocks = [];
      // List<TestDTO> test = [];
      ThemeDTO theme = ThemeDTO(
          element['id'], element['cover'], [], element['title'], []);
      themsDtos.add(theme);
    });
    // ThemeDTO t = (themsDtos.elementAt(id));
    return themsDtos;
  }

@override
Widget build(BuildContext context) {
  var themesFuture = _loadJsonData();
  
  return FutureBuilder<List<ThemeDTO>>(
    future: themesFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Показываем индикатор загрузки, пока данные загружаются
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // Показываем сообщение об ошибке, если произошла ошибка
        return Text('Error: ${snapshot.error}');
      } else {
        // Отображаем список тем, когда данные загружены
        List<ThemeDTO> themes = snapshot.data!;
        
        return Scaffold(
          appBar: AppBar(
            title: Text('Theme List'),
          ),
          body: Center(
            child: SizedBox(
              width: 400,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: themes.length,
                itemBuilder: (context, index) {
                  // Используем элементы из списка загруженных тем
                  ThemeDTO theme = themes[index];
                  return TestPreview(
                    imagePath: theme.cover,
                    text: theme.title,
                    id: theme.id.toString(),
                    proccess: false, //TODO: процесс завершен/не завершен
                  );
                },
              ),
            ),
          ),
        );
      }
    },
  );
}
}

