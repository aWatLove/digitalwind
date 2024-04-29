import 'dart:convert';

import 'package:dw/entities/test/model/dto/test.dart';
import 'package:dw/entities/test/model/dto/theme.dart';
import 'package:dw/entities/test/model/tests_repo.dart';
import 'package:dw/shared/lib/JsonRepository/JsonRepository/json_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class _TestState extends State<TestScreen> {
  int index = 0; //test index
  late final int themeId; // id темы
  late List<int?> selectedAnswers;
  CheckedStatus status = CheckedStatus.idle;
  int? answerIndex;
  late ThemeDTO test;
  _TestState({required this.themeId, this.index = 0});
  Future<void> loadTest() async {
    // Загрузка данных из файла
    String jsonString = await rootBundle.loadString('assets/db.json');
    // Преобразование JSON в список объектов TestDTO
    List<dynamic> jsonList = json.decode(jsonString)['themes'];
    setState(() {
      test = jsonList
          .map((json) => ThemeDTO.fromJson(json))
          .toList()
          .elementAt(widget.themeId);
    });
  }

  @override
  void initState() {
    loadTest();
    selectedAnswers = [
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null
    ];
    // List.filled(test?.test?.length ?? 0, null);
    super.initState();
  }

  void onSubmit() {
    setState(() {
      if(status == CheckedStatus.idle){
        if(selectedAnswers[index]!=null && test.test[index].rightanswer == selectedAnswers[index]){
          status = CheckedStatus.succes;
        }else {
          print(selectedAnswers);
          status = CheckedStatus.rejected;
        }
        return;
      };
      if (index != test.test.length - 1) {
        if (status == CheckedStatus.succes) {
          index += 1;
          status = CheckedStatus.idle;
        }
      }
    });
  }

  void answerQuestion(int answerIndex) {
    setState(() {
      status = CheckedStatus.idle;
      selectedAnswers[index] = answerIndex; // Сохранение выбранного ответа
    });
  }

  @override
  Widget build(BuildContext context) {
    if (test == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Загрузка...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      bool isEnd = index == test.test.length - 1;
      bool isChoosen = selectedAnswers[index] != null;
      return Scaffold(
          bottomSheet: Container(
              width: double.infinity,
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
                    height: 50,
                    child: Visibility(
                        visible: status != CheckedStatus.idle,
                        child: Container(
                          decoration: BoxDecoration(color: Color.fromRGBO(209, 209, 209, 0), borderRadius:BorderRadius.vertical(top: Radius.circular(20)) ),
                          child:Row(
                            
                          children: [
                            SizedBox(width: 15),
                            Icon(status == CheckedStatus.rejected 
                                    ? Icons.remove_circle_outline_sharp 
                                    : Icons.check_circle,
                                color: status == CheckedStatus.rejected
                                    ? Color.fromRGBO(246, 136, 136, 1)
                                    : Color.fromRGBO(136, 246, 193, 1),
                                    size: 40,),
                            SizedBox(width: 10,),
                            Text(status == CheckedStatus.rejected
                                ? 'Неверно :('
                                : 'Замечательно !', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                          ],
                        ))),
                  ),
                  ElevatedButton(

                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(top: 20, bottom: 20)),
                        backgroundColor:
                            MaterialStateProperty.all(status == CheckedStatus.rejected ? Color.fromRGBO(246, 136, 136, 1) : Color.fromRGBO(136, 246, 193, 1))),
                    onPressed: selectedAnswers[index] != null
                        ? () => onSubmit()
                        : null, // Проверка, выбран ли ответ
                    child: Text(style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),isEnd
                        ? 'ЗАКОНЧИТЬ'
                        : isChoosen
                            ? 'СЛЕДУЮЩИЙ'
                            : 'ВЫБЕРИТЕ ОТВЕТ'),
                  )
                ],
              )),
          appBar: AppBar(
            title: Text('${test.title}'),
          ),
          body: 
            Column(
              children: [
                SizedBox(height: 61,),
                Image.asset(test.test[index].cover,fit: BoxFit.cover/*TODO может сломаться*/ ,),
                SizedBox(height: 12,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  child: Text(
                  test.test[index].question,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                )),
                SizedBox(height: 20, width: double.infinity),
                ...(test.test[index].answer as List<String>)
                    .mapIndexed((index, answer) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      
                      backgroundColor: selectedAnswers[this.index] == index
                          ? status == CheckedStatus.rejected ? MaterialStateProperty.all(Color.fromRGBO(246, 136, 136, 1)) : MaterialStateProperty.all(Color.fromRGBO(136, 246, 193, 1))
                          : null, // Зеленый цвет кнопки при выборе ответа
                      
                    ),
                    onPressed: () => answerQuestion(index),
                    child: Container(padding: EdgeInsets.symmetric(vertical: 10), width: 180, height: 65, child:Center(child:Text(answer, style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,))),
                  );
                }).toList(),
                const SizedBox(height: 20)
              ],
            ),
          );
    }
  }
}

class TestScreen extends StatefulWidget {
  final int themeId;
  final int index;

  const TestScreen({
    required this.themeId,
    required this.index,
    super.key,
  });

  @override
  State<TestScreen> createState() {
    // ignore: no_logic_in_create_state
    return _TestState(themeId: themeId, index: index);
  }
}

extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E e) f) sync* {
    var index = 0;
    for (final element in this) {
      yield f(index++, element);
    }
  }
}

enum CheckedStatus { succes, idle, rejected }
