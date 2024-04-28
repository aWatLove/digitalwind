import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import '../json_serializable.dart';
abstract class JsonRepository<T extends JsonSerializable> {
  late List<T> _items;

  JsonRepository();

  Future<void> loadItems() async {
    String jsonString = await rootBundle.loadString('db.json');
    final jsonData = json.decode(jsonString);
    _items = List<T>.from(jsonData.map((item) => fromJson(item)));
  }

  void saveItems() {
    List<dynamic> jsonList = _items.map((item) => item.toJson()).toList();
    String jsonString = json.encode(jsonList);
    
    // Здесь происходит запись данных обратно в файл db.json
    // Для примера, используем rootBundle для записи в файл
    // На практике, вы можете использовать другие методы сохранения, такие как path_provider для записи в файл
    rootBundle
        .loadString('db.json')
        .then((fileContents) => File('db.json').writeAsString(jsonString));
    
    print('Data saved successfully');
  }

  T fromJson(Map<String, dynamic> json);

  void add(T item) {
    _items.add(item);
    saveItems();
  }

  void update(int id, T newItem) {
    int index = _items.indexWhere((item) => (item as dynamic).id == id);
    if (index != -1) {
      _items[index] = newItem;
      saveItems();
    }
  }

  void remove(int id) {
    _items.removeWhere((item) => (item as dynamic).id == id);
    saveItems();
  }

  List<T> get items => _items;
}

class TestDataRepository extends JsonRepository<Test> {
  TestDataRepository() : super();

  @override
  Test fromJson(Map<String, dynamic> json) {
    return Test.fromJson(json);
  }
}

class Test extends JsonSerializable {
  final int id;
  String name;
  int score;

  Test({required this.id, required this.name, required this.score});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      name: json['name'],
      score: json['score'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'score': score};
  }
}

void main() async {
  TestDataRepository repository = TestDataRepository();
  await repository.loadItems();

  // Выводим исходные данные
  for (var test in repository.items) {
    print('ID: ${test.id}, Name: ${test.name}, Score: ${test.score}');
  }

  // Добавляем новый элемент
  repository.add(Test(id: 3, name: 'Test 3', score: 75));

  // Обновляем элемент
  repository.update(1, Test(id: 1, name: 'Updated Test 1', score: 95));

  // Удаляем элемент
  repository.remove(2);

  // Выводим обновленные данные
  print('After:');
  for (var test in repository.items) {
    print('ID: ${test.id}, Name: ${test.name}, Score: ${test.score}');
  }

  // Сохраняем обновленные данные в файл JSON
  repository.saveItems();
}
