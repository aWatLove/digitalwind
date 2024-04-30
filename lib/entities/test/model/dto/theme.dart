import 'package:dw/entities/test/model/consts/consts.dart';
import 'package:dw/entities/test/model/dto/description.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dw/entities/test/model/dto/test.dart';

class ThemeDTO {
  final int id;
  final String cover;
  final String title;
  final List<DescriptionBlock> description_blocks;
  final List<TestDTO> test;
  final String _key;
  ThemeDTO(this.id, this.cover, this.test, this.title, this.description_blocks)
      : _key = "${Consts.finishThemeKey}$id";
  // @override
//   Map<String, dynamic> toJson() {
//     return {
//       'id':id,
//       'cover':cover,
//       'title':title,
//       'description_blocks':description_blocks.map((e) => e.toJson()),
//       'test':test.map((e) => e.toJson()),
//     };
//   }
  String get key => _key;
  factory ThemeDTO.fromJson(Map<String, dynamic> json) {
    List<DescriptionBlock> blocks = [];
    List<TestDTO> tests = [];
    List<dynamic> parsedTests = json['test'];
    List<dynamic> parsedBlocks = json['description_blocks'];
    parsedTests.forEach((element) {
      tests.add(TestDTO.fromJson(element));
    });
    parsedBlocks.forEach((element) {
      DescriptionBlock block = DescriptionBlock.fromJson(element);
      blocks.add(block);
    });
    return ThemeDTO(json['id'] as int, json['cover'] as String, tests,
        json['title'] as String, blocks);
  }
}
