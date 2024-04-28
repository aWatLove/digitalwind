import 'package:dw/entities/test/model/dto/description.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dw/entities/test/model/dto/test.dart';

class ThemeDTO  {
  final int id;
  final String cover;
  final String title;
  final List<DescriptionBlock> description_blocks;
  final List<TestDTO> test;
  ThemeDTO(this.id, this.cover, this.test, this.title, this.description_blocks);
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
  factory ThemeDTO.fromJson(Map<String, dynamic> json) {
    return ThemeDTO(
      json['id'] as int,
      json['cover'] as String,
      json['test'] as List<TestDTO>,
      json['title'] as String,
      json['description_blocks'] as List<DescriptionBlock>
    );
}
}