import 'dart:convert';
import 'package:dw/entities/test/model/dto/test_dto.dart';
import 'package:dw/entities/test/model/dto/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ThemeDetailScreen extends StatelessWidget {
  const ThemeDetailScreen({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> _loadJsonData(int id) async {
    String jsonString = await rootBundle.loadString('assets/db.json');
    List<dynamic> themes = json.decode(jsonString)['themes'];
    Map<String, dynamic> t = themes[id] as Map<String, dynamic>;
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    int id = int.tryParse(args['id'] ?? '0') ?? 0;
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadJsonData(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Map<String, dynamic> data = snapshot.data ?? {};
          return Scaffold(
              appBar: AppBar(title: Text(data['title'])),
              body: Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: const Color(0xF9F7F7),
                    height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(18.0),
                                  bottomRight: Radius.circular(18.0)),
                              child: Image.asset(data['cover'],
                                  width: double.infinity, fit: BoxFit.cover)),
                                  const SizedBox(height: 10),
                           Expanded(child:
                           ClipRRect(borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18.0),
                                  topRight: Radius.circular(18.0)
                                  ), child:  Container(width: double.infinity, alignment: Alignment.topLeft, padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 12.0), decoration: BoxDecoration(color:Colors.white, boxShadow: [BoxShadow(color:Colors.black.withOpacity(0.6), spreadRadius: 2, blurRadius: 10, offset: const Offset(-2,2))]), 
                                  child:   Column(children: [Text(data['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))])))
                          )   
                         
                          // Другие виджеты, использующие данные из JSON
                        ],
                      ))));
        }
      },
    );
  }
}

class ThemeDetailScreen1 extends StatelessWidget {
  final String id;
  const ThemeDetailScreen1({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme_$id'),
      ),
      body: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/theme');
          },
          child: ListTile(
            title: Text(
              'Theme Preview for ID: $id',
              style: Theme.of(context).textTheme.headline6,
            ),
          )),
    );
  }
}
