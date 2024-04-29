import 'package:dw/entities/test/model/tests_repo.dart';
import 'package:dw/entities/test/ui/test_preview.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Theme List'),
        ),
        body: Center(
          child: SizedBox(
            width: 400,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10, // Количество элементов в списке
              itemBuilder: (context, index) {
                // Замените `index.toString()` на ваш реальный идентификатор темы
                // return ThemePreview(id: index.toString(), key: ValueKey(index.toString()));
                return TestPreview(
                  imagePath: "assets/preview/sponge.png",
                  text: "Основы финансовой грамотности",
                  id: index.toString(),
                  proccess: true,
                );
              },
            ),
          ),
        ));
  }
}


