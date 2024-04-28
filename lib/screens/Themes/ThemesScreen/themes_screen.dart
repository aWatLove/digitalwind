import 'package:flutter/material.dart';

class ThemePreview extends StatelessWidget {
  final String id;

  const ThemePreview({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap: () {
      Navigator.pushNamed(context, '/theme', arguments: {'id':id});
    } , child: Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Theme Preview for ID: $id',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Image.asset('assets/preview/moneyGang.png')
        ],
    
    )
    
    );
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
      body: ListView.builder(
        itemCount: 5, // Количество элементов в списке
        itemBuilder: (context, index) {
          // Замените `index.toString()` на ваш реальный идентификатор темы
          return ThemePreview(id: index.toString(), key: ValueKey(index.toString()));
        },
      ),

    );
  }
}
