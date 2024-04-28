import 'dart:convert';
import 'package:dw/entities/test/model/dto/description.dart';
import 'package:dw/entities/test/model/dto/test.dart';
import 'package:dw/entities/test/model/dto/theme.dart';
import 'package:dw/screens/not_found_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ThemeDetailScreen extends StatelessWidget {
  final int id;
  const ThemeDetailScreen(this.id, {super.key});
  
  Future<ThemeDTO> _loadJsonData(int id) async {
    String jsonString = await rootBundle.loadString('assets/db.json');
    List<ThemeDTO> themsDtos = [];
    List<dynamic> themes = json.decode(jsonString)['themes'];
    themes.forEach((element) {
    List<DescriptionBlock> blocks = [];
    List<TestDTO> test = [];
      List<dynamic> blocksParsed = element['description_blocks'];
      List<dynamic> testParsed = element['test'];
      testParsed.forEach((element) {
        test.add(TestDTO.fromJson(element));
      });
      blocksParsed.forEach((element) {
        print(element);
        DescriptionBlock block = DescriptionBlock.fromJson(element);
        blocks.add(block);
      });
      ThemeDTO theme = ThemeDTO(element['id'], element['cover'], test, element['title'], blocks);
      themsDtos.add(theme);
    });
    ThemeDTO t = (themsDtos.elementAt(id));
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeDTO>(
      future: _loadJsonData(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          print(snapshot.error);
          return const Center(child: Four04Page("ошибка 😰"));
        } 
        // else if(snapshot.){
          // return const Four04Page('нет такого курса))');
        // } 
        else{
           ThemeDTO data = snapshot.data as ThemeDTO;
          return Scaffold(
            bottomSheet: Container(
              padding: EdgeInsets.all(5.0) ,
            width:MediaQuery.of(context).size.width, 
            child:ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))
                  ), 
                  padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 248, 222, 199))) ,
                    child: const Text("Начать тест 🔥", 
                    style: TextStyle(color: Color.fromARGB(255, 255, 123, 0), 
            fontWeight: FontWeight.w500)), onPressed: () {
              Navigator.pushNamed(context, '/test', arguments: {id:data.id});
            },)),
              appBar: AppBar(title: Text(data.title)),
              body: Align(
                  alignment: Alignment.center,
                  child:                    Container(
                    color: const Color(0xF9F7F7),

                    height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 600),
                      child:Expanded(child:  ListView(padding: const EdgeInsets.all(5.0) ,children: data.description_blocks.map((e) => BLockItem(e)).toList())))));
        }
      },
    );
  }
}
class BLockItem extends StatelessWidget {
  final DescriptionBlock block;
  BLockItem(this.block);
  @override
  Widget build(BuildContext context) {
    print(block);
    // TODO: implement build
    return Column(
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                                  
                              child: Image.asset(block.cover,
                                  width: double.infinity, fit: BoxFit.cover)),
                          //  Expanded(child:
                                  const SizedBox(height: 11),

                           ClipRRect(borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18.0),
                                  topRight: Radius.circular(18.0)
                                  ), child:  Container(
                                    
                                    width: double.infinity,
                                   alignment: Alignment.topLeft, 
                                  padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 12.0), 
                                  decoration: BoxDecoration(color:Colors.white, boxShadow: [BoxShadow(color:Colors.black.withOpacity(0.6), spreadRadius: 2, blurRadius: 10, offset: const Offset(-2,2))]), 
                                  child:   Column(children: [Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(border: Border(bottom:BorderSide(color: Color.fromARGB(134, 158, 158, 158), width:1.0))),
                                    child:Text(
                                      block.header,
                                       textAlign: TextAlign.left,
                                        textWidthBasis: TextWidthBasis.longestLine, 
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))), Text(block.text, style: const TextStyle(fontSize: 14),)]))),
                          // )   
                                  const SizedBox(height: 11),
                         
                          // Другие виджеты, использующие данные из JSON
                        ],
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
