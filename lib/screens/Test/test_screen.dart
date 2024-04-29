import 'dart:convert';

import 'package:dw/entities/test/model/dto/test.dart';
import 'package:dw/entities/test/model/dto/theme.dart';
import 'package:dw/entities/test/model/tests_repo.dart';
import 'package:dw/shared/lib/JsonRepository/JsonRepository/json_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _TestState extends State<TestScreen> {
  int index = 0; //answer
  late final int themeId;
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
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Visibility(
                        visible: status != CheckedStatus.idle,
                        child: Row(
                          children: [
                            Icon(Icons.close,
                                color: status == CheckedStatus.rejected
                                    ? Colors.red
                                    : Colors.green),
                            Text(status == CheckedStatus.rejected
                                ? 'Неверно :('
                                : 'Замечательно !')
                          ],
                        )),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: selectedAnswers[index] != null
                        ? () => onSubmit()
                        : null, // Проверка, выбран ли ответ
                    child: Text(isEnd
                        ? 'Закончить'
                        : isChoosen
                            ? 'Следующий'
                            : 'Выберите ответ'),
                  )
                ],
              )),
          appBar: AppBar(
            title: Text('Test for Theme ${test.title}'),
          ),
          body: 
            Column(
              children: [
                Image.asset(test.test[index].cover),
                Text(
                  test.test[index].question,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20, width: double.infinity),
                ...(test.test[index].answer as List<String>)
                    .mapIndexed((index, answer) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: selectedAnswers[this.index] == index
                          ? MaterialStateProperty.all(Colors.green)
                          : null, // Зеленый цвет кнопки при выборе ответа
                    ),
                    onPressed: () => answerQuestion(index),
                    child: Text(answer),
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
